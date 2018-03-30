<?php
class ModelDesignTopmenu extends Model {
	public function getMenu() {

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		
		$top_cats = $this->model_catalog_category->getCategories(0);
		$category = "<ul class=\"menu\">\n";
		foreach ($top_cats as $top_cat)	{
			if ($top_cat['top']) {
				$name	= $top_cat['name'];
				$href	= $this->url->link('product/category', 'path=' . $top_cat['category_id']);
				$class	= in_array($top_cat['category_id'], $parts) ?  " class=\"active\"" : "";
				$category .= "<li>\n<a href=\"".$href."\"".$class.">".$name."</a>\n";
				$category .= $this->getCatTree($top_cat['category_id'])."\n</li>\n";
			}
		}
        $category .= '<li><a class="delivery-font" href="/delivery">Доставка и оплата</a></li>';
        $category .= '<li><a class="about_us-font" href="/about_us">Контакты</a></li>';
		return $category."\n</ul>\n";
	} 	

	function getCatTree ($category_id = 0)	{
		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		$this->load->model('catalog/category');
		$this->load->model('catalog/product');
		$category_data = "";

		$categories = $this->model_catalog_category->getCategories((int)$category_id);

		foreach ($categories as $category) {
				$data = array(
					'filter_category_id'  => $category['category_id'],
					'filter_sub_category' => true	
				);		
				$product_total = $this->model_catalog_product->getTotalProducts($data);
			$name = $category['name'] ;
			$href = $this->url->link('product/category', 'path=' . $category['category_id']);
			$class = in_array($category['category_id'], $parts) ?  " class=\"active\"" : "";
			$parent = $this->getCatTree($category['category_id']);
			if ($parent) {
				$class = $class	? " class=\"active\"" : " class=\"parent\"";
			}
			
				$category_data .= "<li>\n<a href=\"".$href."\"".$class.">".$name."</a>".$parent."\n</li>\n";
			

		}

		return strlen($category_data) ? "<ul>\n".$category_data."\n</ul>\n" : "";
	}
}

?>