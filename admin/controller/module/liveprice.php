<?php
//  Live Price 2 / Динамическое обновление цены - Живая цена 2
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ControllerModuleLivePrice extends Controller {
	private $error = array(); 
	
	private function getLinks() {
		
		$data = array();
		
		if (VERSION >= '2.3.0.0') {
			$routeHomePage 				= 'common/dashboard';
			$routeExtensions			= 'extension/extension';
			$routeExtensionsType 	= '&type=module';
			$routeModule 					= 'extension/module/liveprice';
		} else { // OLDER OC
			$routeHomePage 				= 'common/home';
			$routeExtensions			= 'extension/module';
			$routeExtensionsType 	= '';
			$routeModule 					= 'module/liveprice';
		}
		
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_home'),
			'href'      => $this->url->link($routeHomePage, 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => false
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('text_module'),
			'href'      => $this->url->link($routeExtensions, 'token=' . $this->session->data['token'].$routeExtensionsType, 'SSL'),
			'separator' => ' :: '
		);
		$data['breadcrumbs'][] = array(
			'text'      => $this->language->get('module_name'),
			'href'      => $this->url->link($routeModule, 'token=' . $this->session->data['token'], 'SSL'),
			'separator' => ' :: '
		);
		
		$data['action'] = $this->url->link($routeModule, 'token=' . $this->session->data['token'], 'SSL');
	
		$data['cancel'] = $this->url->link($routeExtensions, 'token=' . $this->session->data['token'].$routeExtensionsType, 'SSL');
		
		$data['redirect'] = $this->url->link($routeModule, 'token=' . $this->session->data['token'], 'SSL');
		
		return $data;
	}
	
	public function index() {
		
		$lp_lang = $this->load->language('module/liveprice');
		
		$links = $this->getLinks();

		$this->document->setTitle($this->language->get('module_name'));
		
		$this->load->model('setting/setting');
				
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			
			$this->model_setting_setting->editSetting('liveprice', $this->request->post);		
					
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($links['redirect']);
			
		}
				
		foreach ( $lp_lang as $key => $val ) {
			$data[$key] = $val;
		}
		
		/*
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		*/
		
		$this->load->model('module/liveprice');
		$data['module_version'] = $this->model_module_liveprice->current_version();
		
		$data['config_admin_language'] = $this->config->get('config_admin_language');
		
 		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}
		
		if (isset($this->session->data['success'])) {
      $data['success'] = $this->session->data['success'];
      unset($this->session->data['success']);
    } 

		$data['breadcrumbs'] 		= $links['breadcrumbs'];
		$data['action'] 				= $links['action'];
		$data['cancel'] 				= $links['cancel'];

		$data['liveprice_settings'] = array('discount_quantity'=>0);
		if (isset($this->request->post['liveprice_settings'])) {
			$data['liveprice_settings'] = $this->request->post['liveprice_settings'];
		} elseif ($this->config->get('liveprice_settings')) { 
			$data['liveprice_settings'] = $this->config->get('liveprice_settings');
		}	
		
		$this->load->model('design/layout');
		
		$data['layouts'] = $this->model_design_layout->getLayouts();
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
				
		$this->response->setOutput($this->load->view('module/liveprice.tpl', $data));
	}
	
	private function standardSettings($post=false) {
		if (!$post || is_array($post)) {
			$post = array();
		}
		
		$post['liveprice_module'] = Array ( 0 => Array ( 	'layout_id' => 2
																										,	'position' => 'content_bottom'
																										, 'status' => 1
																										, 'sort_order' => 0
																										) );
		
		return $post;
	}
	
	public function install() {
		
		$post = $this->standardSettings();
		
		$this->load->model('setting/setting');
		$this->model_setting_setting->editSetting('liveprice', $post);
		
	}
	
	
	private function validate() {
		if (!$this->user->hasPermission('modify', 'module/liveprice') && !$this->user->hasPermission('modify', 'extension/module/liveprice')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		
		if (!$this->error) {
			return true;
		} else {
			return false;
		}	
	}
}
