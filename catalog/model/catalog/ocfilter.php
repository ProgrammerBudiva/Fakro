<?php
class ModelCatalogOCFilter extends Model {
  public function getOCFilterOptionsByCategoryId($category_id) {
    $options_data = $this->cache->get('ocfilter.option.' . $category_id . '.' . $this->config->get('config_language_id'));

		if (false !== $options_data) {
			return $options_data;
		}

    $options_data = array();

    $options_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_option oo LEFT JOIN " . DB_PREFIX . "ocfilter_option_description ood ON (oo.option_id = ood.option_id) LEFT JOIN " . DB_PREFIX . "ocfilter_option_to_category cotc ON (oo.option_id = cotc.option_id) WHERE oo.status = '1' AND cotc.category_id = '" . (int)$category_id . "' AND ood.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY oo.sort_order");

    if ($options_query->num_rows) {
      $options_id = array();

      foreach ($options_query->rows as $option) $options_id[] = (int)$option['option_id'];

      $values_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_option_value oov LEFT JOIN " . DB_PREFIX . "ocfilter_option_value_description oovd ON (oov.value_id = oovd.value_id) WHERE oov.option_id IN (" . implode(',', $options_id) . ") AND oovd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY (oovd.name = '-') DESC, (oovd.name = '0') DESC, (oovd.name + 0 > 0) DESC, (oovd.name + 0), LENGTH(oovd.name), oovd.name");

      $values = array();

      foreach ($values_query->rows as $value) $values[$value['option_id']][] = $value;

      $slider_options_id = array();

      foreach ($options_query->rows as $option) {
        $options_data[$option['option_id']] = $option;
        $options_data[$option['option_id']]['slide_value_min'] = 0;
        $options_data[$option['option_id']]['slide_value_max'] = 0;
        $options_data[$option['option_id']]['values'] = array();

        if ($option['type'] == 'slide' || $option['type'] == 'slide_dual') {
          $slider_options_id[] = $option['option_id'];
        }

        if (isset($values[$option['option_id']])) {
          $options_data[$option['option_id']]['values'] = $values[$option['option_id']];
        }
      }

      if ($slider_options_id) {
        $query = $this->db->query("SELECT MIN(oov2p.slide_value_min) AS `min`, GREATEST(MAX(oov2p.slide_value_max), MAX(oov2p.slide_value_min)) AS `max`, oov2p.option_id FROM " . DB_PREFIX . "ocfilter_option_value_to_product oov2p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON(oov2p.product_id = p2c.product_id) WHERE oov2p.value_id = '0' AND oov2p.option_id IN(" . implode(',', $slider_options_id) . ") AND p2c.category_id = '" . (int)$category_id . "' GROUP BY option_id");

        if ($query->num_rows) {
          foreach ($query->rows as $result) {
            if (isset($options_data[$result['option_id']])) {
              $options_data[$result['option_id']]['slide_value_min'] = (float)$result['min'];
              $options_data[$result['option_id']]['slide_value_max'] = (float)$result['max'];
            }
          }
        }
      }
    }

    $this->cache->set('ocfilter.option.' . $category_id . '.' . $this->config->get('config_language_id'), $options_data);

    return $options_data;
  }

  public function getCategorySeoPathByCategoryId($category_id) {
    $query = $this->db->query("SELECT GROUP_CONCAT(DISTINCT ua.`keyword` ORDER BY cp.`level` SEPARATOR '/') AS path FROM " . DB_PREFIX . "category_path cp LEFT JOIN " . DB_PREFIX . "url_alias ua ON (CONCAT('category_id=', cp.path_id) = ua.`query`) WHERE cp.category_id = '" . (int)$category_id . "'");

    if ($query->num_rows) {
    	return $query->row['path'];
    } else {
      return '';
    }
  }

  public function getStockStatuses() {
    $stock_statuses_data = $this->cache->get('ocfilter.stock_status');

		if (false !== $stock_statuses_data) {
			return $stock_statuses_data;
		}

		$query = $this->db->query("SELECT stock_status_id AS value_id, name, 's' AS option_id FROM " . DB_PREFIX . "stock_status WHERE language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY name");

    $stock_statuses_data = $query->rows;

    $this->cache->set('ocfilter.stock_status', $stock_statuses_data);

		return $stock_statuses_data;
	}

  public function getManufacturersByCategoryId($category_id) {
    $manufacturers_data = $this->cache->get('ocfilter.manufacturer.' . (int)$category_id);

		if (false !== $manufacturers_data) {
			return $manufacturers_data;
		}

    $query = $this->db->query("SELECT results.*, ua.keyword FROM (SELECT m.manufacturer_id AS value_id, m.name, 'm' AS option_id FROM " . DB_PREFIX . "manufacturer m LEFT JOIN " . DB_PREFIX . "manufacturer_to_store m2s ON (m.manufacturer_id = m2s.manufacturer_id) LEFT JOIN " . DB_PREFIX . "product p ON (m.manufacturer_id = p.manufacturer_id) LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p2c.category_id = '" . (int)$category_id . "' GROUP BY m.manufacturer_id) results, " . DB_PREFIX . "url_alias ua WHERE CONCAT('manufacturer_id=', results.value_id) = ua.`query` ORDER BY results.name");

    $manufacturers_data = $query->rows;

    $this->cache->set('ocfilter.manufacturer.' . (int)$category_id, $manufacturers_data);

		return $manufacturers_data;
	}

  public function getProductPrices($data) {
		$cache = 'ocfilter.product.price.' . md5(serialize($data));

		$product_price_data = $this->cache->get($cache);

    if (false !== $product_price_data) {
    	return $product_price_data;
    }

    $product_price_data = array(
			'min' => 0,
			'max' => 0,
			'products' => array()
		);

    $sql = "SELECT MIN(`min`) AS `min`, MAX(`max`) AS `max` FROM (SELECT product_id, LEAST(price, discount_special, MIN(option_price)) AS `min`, GREATEST(price, discount_special, MAX(option_price)) AS `max` FROM (SELECT p.product_id, p.price, COALESCE(IF(pov.price_prefix = '-', p.price - pov.price, NULL), IF(pov.price_prefix = '+', p.price + pov.price, NULL), IF(pov.price_prefix = '*', p.price + p.price * pov.price, NULL), IF(pov.price_prefix = '%', p.price + p.price * (pov.price / 100), NULL), IF(pov.price_prefix = '=', pov.price, NULL), p.price + pov.price, p.price) AS option_price, COALESCE((SELECT MIN(pd.price) FROM " . DB_PREFIX . "product_discount pd WHERE pd.product_id = p.product_id AND pd.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd.quantity > '0' AND ((pd.date_start = '0000-00-00' OR pd.date_start < '" . $this->db->escape(date('Y-m-d')) . "') AND (pd.date_end = '0000-00-00' OR pd.date_end > '" . $this->db->escape(date('Y-m-d')) . "'))), (SELECT MIN(ps.price) FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < '" . $this->db->escape(date('Y-m-d')) . "') AND (ps.date_end = '0000-00-00' OR ps.date_end > '" . $this->db->escape(date('Y-m-d')) . "'))), p.price) AS discount_special FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product_to_store p2s ON (p.product_id = p2s.product_id) LEFT JOIN " . DB_PREFIX . "product_option_value pov ON (p.product_id = pov.product_id) WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND p.status = '1' AND p.price > '0' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "' AND p.date_available <= '" . $this->db->escape(date('Y-m-d')) . "'";

    if (!empty($data['filter_ocfilter'])) {
			$sql_product = $this->getProductSQL($data['filter_ocfilter']);

      if ($sql_product) {
				$sql .= $sql_product;
      } else {
        return $product_price_data;
      }
    }

    $sql .= ") prices GROUP BY product_id) results";

    $query = $this->db->query($sql);

    if ($query->row['min'] && $query->row['max'] && $query->row['min'] != $query->row['max']) {
			$product_price_data = array(
				'min' => $query->row['min'],
				'max' => $query->row['max'],
				'products' => array()
			);
    }

    $this->cache->set($cache, $product_price_data);

    return $product_price_data;
  }

  public function getProductSQL($params = array()) {
    $this->load->config('ocfilter');
    $this->load->helper('ocfilter');

    if (!is_array($params)) {
      $params = decodeParamsFromString($params, $this->config);
    }

    $sql = "";

    foreach ($params as $option_id => $values) {
      // Filter by price
      if ($option_id == 'p') {
        $range = getRangeParts(array_shift($values));

        if (isset($range['from']) && isset($range['to'])) {
          $price_from = floor((float)$range['from'] / $this->currency->getValue($this->session->data['currency']));
          $price_to = ceil((float)$range['to'] / $this->currency->getValue($this->session->data['currency']));

          $sql .= " AND (p.price BETWEEN '" . (float)$price_from . "' AND '" . (float)$price_to . "'";

          if ($this->config->get('ocfilter_consider_discount')) {
            $sql .= " OR EXISTS (SELECT pd.product_id FROM " . DB_PREFIX . "product_discount pd WHERE pd.product_id = p.product_id AND pd.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND pd.quantity > '0' AND ((pd.date_start = '0000-00-00' OR pd.date_start < '" . $this->db->escape(date('Y-m-d')) . "') AND (pd.date_end = '0000-00-00' OR pd.date_end > '" . $this->db->escape(date('Y-m-d')) . "')) AND pd.price BETWEEN '" . (float)$price_from . "' AND '" . (float)$price_to . "')";
          }

          if ($this->config->get('ocfilter_consider_special')) {
            $sql .= " OR EXISTS (SELECT ps.product_id FROM " . DB_PREFIX . "product_special ps WHERE ps.product_id = p.product_id AND ps.customer_group_id = '" . (int)$this->config->get('config_customer_group_id') . "' AND ((ps.date_start = '0000-00-00' OR ps.date_start < '" . $this->db->escape(date('Y-m-d')) . "') AND (ps.date_end = '0000-00-00' OR ps.date_end > '" . $this->db->escape(date('Y-m-d')) . "')) AND ps.price BETWEEN '" . (float)$price_from . "' AND '" . (float)$price_to . "')";
          }

          $sql .= ")";
        }

        unset($params[$option_id]);

      // Filter by manufacturer
      } else if ($option_id == 'm') {
        $implode = array();

        foreach ($values as $value_id) {
          $implode[] = "p.manufacturer_id = '" . (int)$value_id . "'";
        }

        if ($implode) {
          $sql .= " AND (" . implode(" OR ", $implode) . ")";
        }

        unset($params[$option_id]);

      // Filter by stock status
      } else if ($option_id == 's') {
        $implode = array();

        if ($this->config->get('ocfilter_stock_status_method') == 'stock_status_id') {
          foreach ($values as $value_id) {
            $implode[] = "p.stock_status_id = '" . (int)$value_id . "'";
          }

          if ($implode) {
            $sql .= " AND (" . implode(" OR ", $implode) . ")";
          }
        } else {
          $stock_status = array_shift($values);

          if ($stock_status == 'in') {
          	$sql .= " AND p.quantity > '0'";
          } else {
          	$sql .= " AND p.quantity < '1'";
          }
        }

        unset($params[$option_id]);

      // Remove other any special filters
      } else if (!isID($option_id)) {
        unset($params[$option_id]);
      }
    }

    // Find by option -> values
    if ($params) {
      $join = array();
      $where = array();

      $count = 1;

      foreach ($params as $option_id => $values) {
        $or = array();

        if (isRange($values[0])) {
          $range = getRangeParts($values[0]);

          if (isset($range['from']) && isset($range['to'])) {
        	  $or[] = "oov2p" . (int)$count . ".slide_value_min BETWEEN '" . (float)$range['from'] . "' AND '" . (float)$range['to'] . "' AND oov2p" . (int)$count . ".slide_value_max BETWEEN '" . (float)$range['from'] . "' AND '" . (float)$range['to'] . "'";
          } else {
            continue;
          }
        } else {
          foreach ($values as $value_id) {
          	$or[] = "oov2p" . (int)$count . ".value_id = '" . $this->db->escape($value_id) . "'";
          }
        }

        if ($or) {
          $where[] = "oov2p" . (int)$count . ".option_id = '" . (int)$option_id . "' AND (" . implode(" OR ", $or) . ")";
        }

        if ($count > 1) {
          $join[] = DB_PREFIX . "ocfilter_option_value_to_product oov2p" . (int)$count . " ON (oov2p1.product_id = oov2p" . (int)$count . ".product_id)";
        }

        $count++;
      }

      if ($where) {
        $sql .= " AND p.product_id IN(SELECT oov2p1.product_id FROM " . DB_PREFIX . "ocfilter_option_value_to_product oov2p1";

        if ($join) {
        	$sql .= " INNER JOIN " . implode(" INNER JOIN ", $join);
        }

        $sql .= " WHERE " . implode(" AND ", $where) . ")";
      }
    }

    return $sql;
  }

	public function getCounters($data = array()) {
		$cache = 'product.ocfilter.counter.' . md5(serialize($data));

		$ocfilter_counter_data = $this->cache->get($cache);

		if (false !== $ocfilter_counter_data) {
			return $ocfilter_counter_data;
		}

    $ocfilter_counter_data = array();

    $union = array();

    // Manufacturers
    $union[] = $this->getManufacturersCounterSQL($data);

    // Stock Status
    if ($this->config->get('ocfilter_stock_status_method') == 'stock_status_id') {
      $union[] = $this->getStockStatusCounterSQL($data);
    } else {
      $union[] = $this->getQuantityCounterSQL($data);
    }

    // Option Values
    $union[] = $this->getOptionValuesCounterSQL($data);

    if ($union) {
      $query = $this->db->query("SELECT value_id, option_id, total FROM (" . implode(" UNION ALL ", $union) . ") results");

      foreach ($query->rows as $result) {
      	$ocfilter_counter_data[$result['option_id'] . $result['value_id']] = $result['total'];

        if (isset($ocfilter_counter_data[$result['option_id'] . 'all'])) {
        	$ocfilter_counter_data[$result['option_id'] . 'all'] += $result['total'];
        } else {
        	$ocfilter_counter_data[$result['option_id'] . 'all'] = $result['total'];
        }
      }

      $cached = true;

      // Not cached price and sliders
      if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
        $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

        if (isset($params['p'])) {
          $cached = false;
        } else {
          foreach ($params as $option_id => $values) {
            if (isRange(array_shift($values))) {
              $cached = false;

              break;
            }
          }
        }
      }

      if ($cached) {
        $this->cache->set($cache, $ocfilter_counter_data);
      }
    }

		return $ocfilter_counter_data;
	}

  private function getManufacturersCounterSQL($data) {
    $sql = "SELECT p.manufacturer_id AS value_id, 'm' AS option_id, COUNT(p.manufacturer_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";

    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['m'])) {
        unset($params['m']);
      }

    	$product_sql = $this->getProductSQL($params);

      if ($product_sql) {
      	$sql .= $product_sql;
      }
    }

    $sql .= " GROUP BY p.manufacturer_id";

    return $sql;
  }

  private function getStockStatusCounterSQL($data) {
    $sql = "SELECT p.stock_status_id AS value_id, 's' AS option_id, COUNT(p.stock_status_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";

    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['s'])) {
        unset($params['s']);
      }

    	$product_sql = $this->getProductSQL($params);

      if ($product_sql) {
      	$sql .= $product_sql;
      }
    }

    $sql .= " GROUP BY p.stock_status_id";

    return $sql;
  }

  private function getQuantityCounterSQL($data) {
    $sql = "SELECT IF(p.quantity > '0', 'in', 'out') AS value_id, 's' AS option_id, COUNT(*) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) WHERE p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";

    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);

      if (isset($params['s'])) {
        unset($params['s']);
      }

    	$product_sql = $this->getProductSQL($params);

      if ($product_sql) {
      	$sql .= $product_sql;
      }
    }

    $sql .= " GROUP BY value_id";

    return $sql;
  }

  private function getOptionValuesCounterSQL($data) {
    if (isset($data['filter_ocfilter']) && !is_null($data['filter_ocfilter'])) {
      $params = decodeParamsFromString($data['filter_ocfilter'], $this->config);
    } else {
      $params = array();
    }

    // All Options and values
    $sql = "SELECT oov2p.value_id, oov2p.option_id, COUNT(p.product_id) AS total FROM " . DB_PREFIX . "ocfilter_option_value_to_product oov2p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (oov2p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "product p ON (oov2p.product_id = p.product_id) WHERE oov2p.value_id > '0' AND p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";

    if ($params) {
    	$product_sql = $this->getProductSQL($params);

      if ($product_sql) {
      	$sql .= $product_sql;
      }
    }

    $sql .= " GROUP BY oov2p.option_id, oov2p.value_id";

    $union = array();

    // Selecteds
    if ($params) {
      $added = array();

      foreach ($params as $option_id => $values) {
        if ($option_id == 'p' || $option_id == 'm' || $option_id == 's' || isRange($values[0])) {
        	continue;
        }

        $_params = $params;

        if (!in_array($option_id, $added)) {
          unset($_params[$option_id]);

          $added[] = $option_id;
        }

        $union[$option_id] = "SELECT oov2p.value_id, oov2p.option_id, COUNT(p.product_id) AS total FROM " . DB_PREFIX . "product p LEFT JOIN " . DB_PREFIX . "product_to_category p2c ON (p.product_id = p2c.product_id) LEFT JOIN " . DB_PREFIX . "ocfilter_option_value_to_product oov2p ON (p.product_id = oov2p.product_id) WHERE oov2p.option_id = '" . (int)$option_id . "' AND p.status = '1' AND p2c.category_id = '" . (int)$data['filter_category_id'] . "'";

      	$product_sql = $this->getProductSQL($_params);

        if ($product_sql) {
        	$union[$option_id] .= $product_sql;
        }

        $union[$option_id] .= " GROUP BY oov2p.option_id, oov2p.value_id";
      }
    }

    if ($union) {
    	$sql .= " UNION ALL " . implode(" UNION ALL ", $union);
    }

    return $sql;
  }

	public function getPage($category_id, $ocfilter_params) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_page WHERE status = '1' AND category_id = '" . (int)$category_id . "' AND ocfilter_params = '" . $this->db->escape($ocfilter_params) . "'");

		return $query->row;
	}

	public function getPages() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ocfilter_page WHERE status = '1'");

		return $query->rows;
	}
}

?>