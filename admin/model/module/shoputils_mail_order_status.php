<?php
/*
 * Shoputils
 *
 * ПРИМЕЧАНИЕ К ЛИЦЕНЗИОННОМУ СОГЛАШЕНИЮ
 *
 * Этот файл связан лицензионным соглашением, которое можно найти в архиве,
 * вместе с этим файлом. Файл лицензии называется: LICENSE.2.x.RUS.TXT
 * Так же лицензионное соглашение можно найти по адресу:
 * http://opencart.shoputils.ru/LICENSE.2.x.RUS.TXT
 * 
 * =================================================================
 * OPENCART/ocStore 2.x ПРИМЕЧАНИЕ ПО ИСПОЛЬЗОВАНИЮ
 * =================================================================
 *  Этот файл предназначен для Opencart/ocStore 2.x. Shoputils не
 *  гарантирует правильную работу этого расширения на любой другой 
 *  версии Opencart/ocStore, кроме Opencart/ocStore 2.x. 
 *  Shoputils не поддерживает программное обеспечение для других 
 *  версий Opencart/ocStore.
 * =================================================================
*/

class ModelModuleShoputilsMailOrderStatus extends Model {
    private $_http_root;
    const SIMPLE_PATH   = 'model/module/simplecustom.php';
    const SIMPLE_MODEL  = 'module/simplecustom';
    const SIMPLE_OBJECT = 'model_module_simplecustom';
    const SIMPLE_METHOD = 'getCustomFields';
    private static $_simple_objects = array(
        'order'    => 1,
        'customer' => 2,
        'address'  => 3
    );


   public function __construct($registry) {
        parent::__construct($registry);
        $this->_http_root = HTTP_CATALOG;
    }

    public function confirmOrder($order_id, $order_status_id, $admin_comment = '') {
        if (!$this->config->get('shoputils_mail_order_status_new_status')) {
            return false;
        }

				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return false;
				}

		    $subject = $this->config->get('shoputils_mail_order_status_new_subject');
		    $subject = $subject[(int)$order_info['language_id']];
		    $content = $this->config->get('shoputils_mail_order_status_new_content');
		    $content = $content[(int)$order_info['language_id']];

				$this->sendMail($subject, $content, $order_info, $order_status_id, $admin_comment, 'customer');
				return true;
    }

    public function confirmOrderAdmin($order_id, $order_status_id, $admin_comment = '') {
        if (!$this->config->get('shoputils_mail_order_status_admin_new_status')) {
            return false;
        }

				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return false;
				}

		    $subject = $this->config->get('shoputils_mail_order_status_admin_new_subject');
		    $subject = $subject[(int)$this->config->get('config_language_id')];
		    $content = $this->config->get('shoputils_mail_order_status_admin_new_content');
		    $content = $content[(int)$this->config->get('config_language_id')];

				$this->sendMail($subject, $content, $order_info, $order_status_id, $admin_comment, 'admin');
				return true;
    }

    //admin_comment - коммент админа; $admin_notify - галка "Уведомить покупателя" из истории "Заказы->Продажи";
    //$send: true - отправка письма, false - проверка на возможность отправки; $trackcode - $data['trackcode'] из model/sale/order для {trackcode} и [trackcode_link]
    public function updateOrder($order_id, $order_status_id, $admin_comment = '', $admin_notify = true, $send = true, $trackcode = '', $attachment = false) {
        if (!$this->config->get('shoputils_mail_order_status_status' . $order_status_id)) {
            return false;
        }

        if ($this->config->get('shoputils_mail_order_status_notify' . $order_status_id) && !$admin_notify) {
            return false;
        }

				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return false;
				}

		    $subject = $this->config->get('shoputils_mail_order_status_subject' . $order_status_id);
		    $subject = $subject[(int)$order_info['language_id']];
		    //$subject = $subject[(int)$this->config->get('config_language_id')];
		    $content = $this->config->get('shoputils_mail_order_status_content' . $order_status_id);
		    $content = $content[(int)$order_info['language_id']];
		    //$content = $content[(int)$this->config->get('config_language_id')];

				if ($send) {
            $this->sendMail($subject, $content, $order_info, $order_status_id, $admin_comment, 'customer', $trackcode, $attachment);
				}
				return true;
    }

    public function updateOrderAdmin($order_id, $order_status_id, $admin_comment = '', $trackcode = '', $attachment = false) {
        if (!$this->config->get('shoputils_mail_order_status_admin_status' . $order_status_id)) {
            return false;
        }

				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return false;
				}

		    $subject = $this->config->get('shoputils_mail_order_status_admin_subject' . $order_status_id);
		    $subject = $subject[(int)$this->config->get('config_language_id')];
		    $content = $this->config->get('shoputils_mail_order_status_admin_content' . $order_status_id);
		    $content = $content[(int)$this->config->get('config_language_id')];

				$this->sendMail($subject, $content, $order_info, $order_status_id, $admin_comment, 'admin', $trackcode, $attachment);
				return true;
    }

    protected function sendMail($subject, $content, $order_info, $order_status_id, $admin_comment, $type = 'admin', $trackcode = '', $attachment = false) {
				$order_link = $order_info['store_url'] . 'index.php?route=account/order/info&order_id=' . $order_info['order_id'];
				$trackcode_link = 'http://gdeposylka.ru/' . $trackcode;
				$trackcode_link2 = 'https://moyaposylka.ru/' . $trackcode;
				
				$input = array(
            '{order_id}',
				    '{store_name}',
						'{logo}',
						'{order_status}',
						'{order_link}',
						'{comment}',
						'{admin_comment}',
						'{ip}',
						'{location}',
						'{date_added}',
						'{date_modified}',
						'{firstname}',
						'{lastname}',
						'{group}',
						'{email}',
						'{telephone}',
						'{products}',
						'{totals}',
						'{total}',
						'{shipping_total}',
						'{product_first}',
						'{product_last}',

						'{payment_firstname}',
						'{payment_lastname}',
						'{payment_company}',
						'{payment_address_1}',
						'{payment_address_2}',
						'{payment_city}',
						'{payment_postcode}',
						'{payment_country}',
						'{payment_zone}',
						'{payment_method}',

						'{shipping_firstname}',
						'{shipping_lastname}',
						'{shipping_company}',
						'{shipping_address_1}',
						'{shipping_address_2}',
						'{shipping_city}',
						'{shipping_postcode}',
						'{shipping_country}',
						'{shipping_zone}',
						'{shipping_method}',

						'{trackcode}',
						'{trackcode_link}',
						'{trackcode_link2}'
			  );

				$output = array(
            'order_id'            => $order_info['order_id'],
				    'store_name'          => $this->config->get('config_name'),
				    'logo'                => '<a href="' . $this->_http_root . '"><img src="' . $this->_http_root . 'image/' . $this->config->get('config_logo') . '" / ></a>',
						'order_status'        => $this->getOrderStatusById($order_status_id, $order_info['language_id']),
						'order_link'          => sprintf('<a href="%s" target="_blank">%s</a>', $order_link, $order_link),
						'comment'             => nl2br($order_info['comment']),
						'admin_comment'       => nl2br($admin_comment),
						'ip'                  => $order_info['ip'],
						'location'            => $order_info['location'],
						'date_added'          => $order_info['date_added'],
						'date_modified'       => $order_info['date_modified'],
						'firstname'           => $order_info['firstname'],
						'lastname'            => $order_info['lastname'],
						'group'               => $this->getCustomerGroup($order_info['customer_group_id']),
						'email'               => $order_info['email'],
						'telephone'           => $order_info['telephone'],
						'products'            => $this->getProducts($order_info['order_id']),
						'totals'              => $this->getTotals($order_info['order_id']),
						'total'               => $this->currency->format($order_info['total'], $order_info['currency_code'], $order_info['currency_value']),
						'shipping_total'      => $this->getShippingTotal($order_info['order_id']),
						'product_first'       => $this->getProductFirst($order_info['order_id']),
						'product_last'        => $this->getProductLast($order_info['order_id']),

						'payment_firstname'   => $order_info['payment_firstname'],
						'payment_lastname'    => $order_info['payment_lastname'],
						'payment_company'     => $order_info['payment_company'],
						'payment_address_1'   => $order_info['payment_address_1'],
						'payment_address_2'   => $order_info['payment_address_2'],
						'payment_city'        => $order_info['payment_city'],
						'payment_postcode'    => $order_info['payment_postcode'],
						'payment_country'     => $order_info['payment_country'],
						'payment_zone'        => $order_info['payment_zone'],
						'payment_method'      => $order_info['payment_method'],

						'shipping_firstname'  => $order_info['shipping_firstname'],
						'shipping_lastname'   => $order_info['shipping_lastname'],
						'shipping_company'    => $order_info['shipping_company'],
						'shipping_address_1'  => $order_info['shipping_address_1'],
						'shipping_address_2'  => $order_info['shipping_address_2'],
						'shipping_city'       => $order_info['shipping_city'],
						'shipping_postcode'   => $order_info['shipping_postcode'],
						'shipping_country'    => $order_info['shipping_country'],
						'shipping_zone'       => $order_info['shipping_zone'],
						'shipping_method'     => $order_info['shipping_method'],

						'trackcode'           => $trackcode,
						'trackcode_link'      => $trackcode ? sprintf('<a href="%s" target="_blank">%s</a>', $trackcode_link, $trackcode_link) : '',
						'trackcode_link2'     => $trackcode ? sprintf('<a href="%s" target="_blank">%s</a>', $trackcode_link2, $trackcode_link2) : ''
			  );

        //Get Simple Data
        $this->load->model('localisation/language');
        $language_info = $this->model_localisation_language->getLanguage($order_info['language_id']);
        $language_code = $language_info ? $language_info['code'] : $this->config->get('config_language');

        foreach($this->getSimpleData('order', $order_info['order_id'], $language_code) as $id => $value) {
            if (strpos($id, 'shipping_') === 0) {
                $id = str_replace('shipping_', 'simple_', $id);
                $input[] = '{' . $id . '}';
                $output[$id] = $value;
            } elseif (strpos($id, 'payment_') === false) {
                $id = 'simple_' . $id;
                $input[] = '{' . $id . '}';
                $output[$id] = $value;
            }
        }

		    $subject = html_entity_decode(trim(str_replace($input, $output, $subject)), ENT_QUOTES, 'UTF-8');
		    $content = html_entity_decode(str_replace($input, $output, $content), ENT_QUOTES, 'UTF-8');
		    $to = $type == 'admin' ? $this->config->get('config_email') : $order_info['email'];
		    $this->_sendMail($subject, $content, $type, $to, $attachment);
    }

    protected function _sendMail($subject, $content, $type, $to, $attachment) {
				$message  = '<html dir="ltr" lang="en">' . "\n";
				$message .= '  <head>' . "\n";
				$message .= '    <title>' . $subject . '</title>' . "\n";
				$message .= '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
				$message .= '  </head>' . "\n";
				$message .= '  <body>' . $content . '</body>' . "\n";
				$message .= '</html>' . "\n";

				//echo $message;
				//exit;
				/////////////////////////////////
				$mail = new Mail();
				$mail->protocol   = $this->config->get('config_mail_protocol');
				$mail->parameter  = $this->config->get('config_mail_parameter');
				$mail->hostname   = $this->config->get('config_smtp_host');
				$mail->username   = $this->config->get('config_smtp_username');
				$mail->password   = $this->config->get('config_smtp_password');
				$mail->port       = $this->config->get('config_smtp_port');
				$mail->timeout    = $this->config->get('config_smtp_timeout');
				$mail->setTo($to);
        $mail->setFrom($this->config->get('config_email'));
				$mail->setSender($this->config->get('config_name'));
				$mail->setSubject($subject);
				$mail->setHtml($message);
        if ($attachment) {
            $mail->addAttachment($attachment);
        }
				$mail->send();

				if ($type == 'admin') {
          $emails = explode(',', $this->config->get('config_alert_emails'));
          foreach ($emails as $email) {
            if ($email && preg_match('/^[^\@]+@.*\.[a-z]{2,6}$/i', $email)) {
              $mail->setTo($email);
              $mail->send();
            }
          }
				}
    }

    public function getOrderStatusById($order_status_id, $language_id = false) {
        if (!$language_id) {
          $language_id = (int)$this->config->get('config_language_id');
        }
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_status WHERE order_status_id = '" . (int)$order_status_id . "' AND language_id = '" . $language_id . "'");
        return $query->num_rows ? $query->row['name'] : '';
    }

    public function getCustomerGroup($customer_group_id) {
        if ($this->getVersion() >= 153) {
          $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_group cg LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (cg.customer_group_id = cgd.customer_group_id) WHERE cg.customer_group_id = '" . (int)$customer_group_id . "' AND cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'");
        } else {  //v1.5.2.1 & low
          $query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "customer_group WHERE customer_group_id = '" . (int)$customer_group_id . "'");
        }
        return $query->num_rows ? $query->row['name'] : '';
    }

    public function getTotals($order_id) {
				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return '';
				}

		    $totals_ft = $this->config->get('shoputils_mail_order_status_totals_ft');
		    $totals_ft = $totals_ft[(int)$order_info['language_id']];
		    $totals_header_ft = $this->config->get('shoputils_mail_order_status_totals_header_ft');
		    $totals_header_ft = $totals_header_ft[(int)$order_info['language_id']];
		    $totals_footer_ft = $this->config->get('shoputils_mail_order_status_totals_footer_ft');
		    $totals_footer_ft = $totals_footer_ft[(int)$order_info['language_id']];
		    $totals = $this->getOrdertotals($order_id);

				$order_totals = '';
				foreach ($totals as $total) {
            $input = array(
                '{totals_title}',
                '{totals_text}'
            );

            $output = array(
                'totals_title'        => $total['title'],
                'totals_text'          => $total['text']
            );
            $order_totals .= str_replace($input, $output, $totals_ft);
			  }

		    return html_entity_decode($totals_header_ft . $order_totals . $totals_footer_ft, ENT_QUOTES, 'UTF-8');
    }

    public function getProducts($order_id) {
				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return '';
				}

		    $products_ft = $this->config->get('shoputils_mail_order_status_products_ft');
		    $products_ft = $products_ft[(int)$order_info['language_id']];
		    $products_header_ft = $this->config->get('shoputils_mail_order_status_products_header_ft');
		    $products_header_ft = $products_header_ft[(int)$order_info['language_id']];
		    $products_footer_ft = $this->config->get('shoputils_mail_order_status_products_footer_ft');
		    $products_footer_ft = $products_footer_ft[(int)$order_info['language_id']];
		    $products = $this->getOrderProducts($order_id);

				$order_products = '';
				foreach ($products as $product) {
            $input = array(
                '{products_image}',
                '{products_name}',
                '{products_href}',
                '{products_model}',
                '{products_sku}',
                '{products_upc}',
                '{products_ean}',
                '{products_jan}',
                '{products_isbn}',
                '{products_mpn}',
                '{products_manufacturer}',
                '{products_quantity}',
                '{products_price}',
                '{products_total}',
                '{products_reward}'
            );

            $output = array(
                'products_image'        => '<a href="' . $product['link'] . '" target="_blank"><img src="' . $product['image'] . '" alt="' . $product['image'] . '" width="80" height="80" /></a>',
                'products_name'         => '<a href="' . $product['link'] . '" target="_blank">' . $product['name'] . '</a>' . ($product['options'] ? '<br />' . $product['options'] : ''),
                'products_href'         => $product['link'],
                'products_model'        => $product['model'],
                'products_sku'          => $product['sku'],
                'products_upc'          => $product['upc'],
                'products_ean'          => $product['ean'],
                'products_jan'          => $product['jan'],
                'products_isbn'         => $product['isbn'],
                'products_mpn'          => $product['mpn'],
                'products_manufacturer' => $product['manufacturer'],
                'products_quantity'     => $product['quantity'],
                'products_price'        => $product['price'],
                'products_total'        => $product['total'],
                'products_reward'       => $product['reward']
            );
            $order_products .= str_replace($input, $output, $products_ft);
			  }

		    return html_entity_decode($products_header_ft . $order_products . $products_footer_ft, ENT_QUOTES, 'UTF-8');
    }

    public function getProductFirst($order_id) {
				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return '';
				}

		    $product_first_ft = $this->config->get('shoputils_mail_order_status_product_first_ft');
		    $product_first_ft = $product_first_ft[(int)$order_info['language_id']];
		    $products = $this->getOrderProducts($order_id);
		    $product = $products[0];

				$order_product = '';
        $input = array(
            '{products_image}',
            '{products_name}',
            '{products_href}',
            '{products_model}',
            '{products_sku}',
            '{products_upc}',
            '{products_ean}',
            '{products_jan}',
            '{products_isbn}',
            '{products_mpn}',
            '{products_manufacturer}',
            '{products_quantity}',
            '{products_price}',
            '{products_total}',
            '{products_reward}'
        );

        $output = array(
            'products_image'        => '<a href="' . $product['link'] . '" target="_blank"><img src="' . $product['image'] . '" alt="' . $product['image'] . '" width="80" height="80" /></a>',
            'products_name'         => '<a href="' . $product['link'] . '" target="_blank">' . $product['name'] . '</a>' . ($product['options'] ? ' ' . $product['options'] : ''),
            'products_href'         => $product['link'],
            'products_model'        => $product['model'],
            'products_sku'          => $product['sku'],
            'products_upc'          => $product['upc'],
            'products_ean'          => $product['ean'],
            'products_jan'          => $product['jan'],
            'products_isbn'         => $product['isbn'],
            'products_mpn'          => $product['mpn'],
            'products_manufacturer' => $product['manufacturer'],
            'products_quantity'     => $product['quantity'],
            'products_price'        => $product['price'],
            'products_total'        => $product['total'],
            'products_reward'       => $product['reward']
        );
        $order_product .= str_replace($input, $output, $product_first_ft);

		    return html_entity_decode($order_product, ENT_QUOTES, 'UTF-8');
    }

    public function getProductLast($order_id) {
				$order_info = $this->getOrder($order_id);
				if (!$order_info) {
            return '';
				}

		    $product_last_ft = $this->config->get('shoputils_mail_order_status_product_last_ft');
		    $product_last_ft = $product_last_ft[(int)$order_info['language_id']];
		    $products = $this->getOrderProducts($order_id);
		    $product = array_pop($products);

				$order_product = '';
        $input = array(
            '{products_image}',
            '{products_name}',
            '{products_href}',
            '{products_model}',
            '{products_sku}',
            '{products_upc}',
            '{products_ean}',
            '{products_jan}',
            '{products_isbn}',
            '{products_mpn}',
            '{products_manufacturer}',
            '{products_quantity}',
            '{products_price}',
            '{products_total}',
            '{products_reward}'
        );

        $output = array(
            'products_image'        => '<a href="' . $product['link'] . '" target="_blank"><img src="' . $product['image'] . '" alt="' . $product['image'] . '" width="80" height="80" /></a>',
            'products_name'         => '<a href="' . $product['link'] . '" target="_blank">' . $product['name'] . '</a>' . ($product['options'] ? ' ' . $product['options'] : ''),
            'products_href'         => $product['link'],
            'products_model'        => $product['model'],
            'products_sku'          => $product['sku'],
            'products_upc'          => $product['upc'],
            'products_ean'          => $product['ean'],
            'products_jan'          => $product['jan'],
            'products_isbn'         => $product['isbn'],
            'products_mpn'          => $product['mpn'],
            'products_manufacturer' => $product['manufacturer'],
            'products_quantity'     => $product['quantity'],
            'products_price'        => $product['price'],
            'products_total'        => $product['total'],
            'products_reward'       => $product['reward']
        );
        $order_product .= str_replace($input, $output, $product_last_ft);

		    return html_entity_decode($order_product, ENT_QUOTES, 'UTF-8');
    }

    public function getShippingTotal($order_id) {
        $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' AND code = 'shipping'");
        return $query->num_rows ? $query->row['text'] : '';
    }

    public function getOrder($order_id) {
      $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order` WHERE order_id = '" . (int)$order_id . "'");
      return $query->num_rows ? $query->row : false;
    }

    public function getSimpleData($object = 'order', $order_id = 0, $language_code = '') {
        if ($this->isSimpleExists()) {
            $this->load->model(self::SIMPLE_MODEL);
                if (method_exists($this->{self::SIMPLE_OBJECT}, self::SIMPLE_METHOD)) {
                    //Simple v4.x
                    $language_code = $language_code ? $language_code : $this->config->get('config_language');
                    return $this->{self::SIMPLE_OBJECT}->{self::SIMPLE_METHOD}($object, $order_id, $language_code);
                } else {
                    //Simple v3.x
                    return $this->getSimpleDataFromOldFormat($object, $order_id);
                }
        } else {
            return array();
        }
    }

    public function isSimpleExists() {
        return file_exists(DIR_APPLICATION . self::SIMPLE_PATH);
    }

    protected function getOrderTotals($order_id) {
       $query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "' ORDER BY sort_order");
       //$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "order_total` WHERE order_id = '" . (int)$order_id . "'");
        return $query->num_rows ? $query->rows : array();
    }

    protected function getOrderProducts($order_id) {
        $this->load->model('catalog/product');
        $this->load->model('tool/image');
        
        $order_info = $this->getOrder($order_id);
        $order_product_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_product WHERE order_id = '" . (int)$order_id . "'");
        $order_download_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_download WHERE order_id = '" . (int)$order_id . "'");
        if ($this->getVersion() >= 152) {
            $order_voucher_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_voucher WHERE order_id = '" . (int)$order_id . "'");
        }
				
				$result = array();
				foreach ($order_product_query->rows as $product) {
					//$result .= $product['quantity'] . 'x ' . $product['name'] . ' (' . $product['model'] . ') ' . html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8') . '<br />';
					$order_option_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "order_option WHERE order_id = '" . (int)$order_id . "' AND order_product_id = '" . $product['order_product_id'] . "'");
					
					$options ='';
					foreach ($order_option_query->rows as $option) {
						if ($option['type'] != 'file') {
							$value = $option['value'];
						} else {
							$value = utf8_substr($option['value'], 0, utf8_strrpos($option['value'], '.'));
						}
											
						$options .= chr(9) . '-' . $option['name'] . ' ' . (utf8_strlen($value) > 20 ? utf8_substr($value, 0, 20) . '..' : $value) . '<br />';
					}

          $product_info = $this->model_catalog_product->getProduct($product['product_id']);

          $image = (isset($product_info['image']) && $product_info['image']) ?
                   $this->model_tool_image->resize($product_info['image'], 80, 80) :
                   $this->model_tool_image->resize('no_image.jpg', 80, 80);
          
          $result[] = array(
            'product_id'    => $product['product_id'],
            'link'          => $order_info['store_url'] . 'index.php?route=product/product/&product_id=' . $product['product_id'],
            'image'         => $image,
            'name'          => $product['name'],
            'model'         => $product['model'],
            'quantity'      => $product['quantity'],
            'tax'           => $product['tax'],
            'price'         => html_entity_decode($this->currency->format($product['price'] + ($this->config->get('config_tax') ? $product['tax'] : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8'),
            'total'         => html_entity_decode($this->currency->format($product['total'] + ($this->config->get('config_tax') ? ($product['tax'] * $product['quantity']) : 0), $order_info['currency_code'], $order_info['currency_value']), ENT_NOQUOTES, 'UTF-8'),
            'reward'        => $product['reward'],
            'sku'           => isset($product_info['sku']) ? $product_info['sku'] : '',
            'upc'           => isset($product_info['upc']) ? $product_info['upc'] : '',
            'ean'           => isset($product_info['ean']) ? $product_info['ean'] : '',
            'jan'           => isset($product_info['jan']) ? $product_info['jan'] : '',
            'isbn'          => isset($product_info['isbn']) ? $product_info['isbn'] : '',
            'mpn'           => isset($product_info['mpn']) ? $product_info['mpn'] : '',
            'manufacturer'  => isset($product_info['manufacturer']) ? $product_info['manufacturer'] : '',
            'options'       => $options
					);
				}
				
				/* if (isset($order_voucher_query)) {
            foreach ($order_voucher_query->rows as $voucher) {
              $result .= '1x ' . $voucher['description'] . ' ' . $this->currency->format($voucher['amount'], $order_info['currency_code'], $order_info['currency_value']);
            }
				} */
				return $result;
    }

    protected function getSimpleDataFromOldFormat($object, $id) {
        $query = $this->db->query("SHOW TABLES LIKE 'simple_custom_data'");
        if (!$query->rows) {
            //Simple not Installed
            return array();
        }

        //Get Simple Data
        $object = !empty(self::$_simple_objects[$object]) ? self::$_simple_objects[$object] : 0;

        if (!$object || !$id) {
            return array();
        }

        $query = $this->db->query("SELECT DISTINCT data FROM simple_custom_data WHERE object_type = '" . (int)$object . "' AND object_id = '" . (int)$id . "'");

        $result = array();

        if ($query->num_rows) {
            $data = unserialize($query->row['data']);

            foreach ($data as $key => $item) {
                $result[$key] = !empty($item['text']) ? $item['text'] : '';
            }
        }

        return $result;
    }

    protected function getVersion() {
        $version = explode('.', VERSION);
        $rev= isset($version[3]) ? 0.1*$version[3] : 0;
        $main = $version[0].$version[1].$version[2];
        return (int)$main + $rev;
    }
}
?>