<?php
//  Live Price 2 / Динамическое обновление цены - живая цена 2
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ControllerModuleLivePrice extends Controller {

	public function get_price() {
		
		if ( $this->config->get('config_customer_price') && !$this->customer->isLogged() ) {
			$this->response->setOutput(json_encode(array()));
			return;
		}
		
		if (isset($this->request->get['product_id'])) {
			$product_id = (int)$this->request->get['product_id'];
		} else {
			exit;
		}
		
		if (isset($this->request->get['quantity'])) {
			$quantity = (int)$this->request->get['quantity'];
		} else {
			$quantity = 1;
		}
		
		if (isset($this->request->post['option_oc'])) {
			$options = $this->request->post['option_oc'];
		} elseif (isset($this->request->post['option'])) {
			$options = $this->request->post['option'];
		} else {
			$options = array();
		}
		
		$non_standard_theme = '';
		if ( isset($this->request->get['non_standard_theme']) ) {
			$non_standard_theme = $this->request->get['non_standard_theme'];
		}
		
		
		$this->load->model('module/liveprice');
		
		$lp_data = $this->model_module_liveprice->getProductPriceWithHtml( $product_id, max($quantity, 1), $options, array(), array(), array(), true, $non_standard_theme );

		// return only required data
		$prices = array('htmls'=>$lp_data['prices']['f_price_opt'], 'ct'=>$lp_data['prices']['ct']);
		if (isset($this->request->get['rnd'])) {
			$prices['rnd'] = $this->request->get['rnd'];
		}
		
		$this->response->setOutput(json_encode($prices));
			
	}
	
	
}
