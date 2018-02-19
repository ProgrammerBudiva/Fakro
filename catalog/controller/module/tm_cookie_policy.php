<?php
class ControllerModuleTmCookiePolicy extends Controller {
	public function index($setting) {
		$this->load->language('module/tm_cookie_policy');
		
		$this->document->addStyle('catalog/view/javascript/tmcookiepolicy/tmcookiepolicy.css');
		
		$data['text_cookie_close'] = $this->language->get('text_cookie_close');
		$data['text_cookie'] = $this->language->get('text_cookie');
		$data['heading_title'] = $this->language->get('heading_title');

		$data['geocode'] = $this->config->get('config_geocode');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/tm_cookie_policy.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/tm_cookie_policy.tpl', $data);
		} else {
			return $this->load->view('default/template/module/tm_cookie_policy.tpl', $data);
		}
		
	}
	
}