<?php
class ControllerModuleTmGoogleMap extends Controller {
	public function index($setting) {
		$this->load->language('module/tm_google_map');

        $this->document->addStyle('catalog/view/javascript/tmgooglemap/tmgooglemap.css');
        if ($this->config->get('tm_google_map_sensor') == 1){
		    $this->document->addScript('https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&sensor=true');
        }else{
            $this->document->addScript('https://maps.googleapis.com/maps/api/js?v=3.exp&signed_in=true&sensor=false');
        }
		$this->document->addScript('catalog/view/javascript/tmgooglemap/jquery.rd-google-map.js');

		
		
		$data['heading_title'] = $this->language->get('heading_title');

		$data['main_geocode'] = $this->config->get('config_geocode');
        $data['main_address'] = $this->config->get('config_address');

        $data['address'] = $this->config->get('tm_google_map_address');
        $data['geocode'] = $this->config->get('tm_google_map_geocode');
		$data['zoom'] = $this->config->get('tm_google_map_zoom');
		$data['type'] = $this->config->get('tm_google_map_type');
		$data['width'] = $this->config->get('tm_google_map_width');
		$data['height'] = $this->config->get('tm_google_map_height');

        if (strlen(trim($this->config->get('tm_google_map_styles'))) > 0){
			$data['styles'] = trim($this->config->get('tm_google_map_styles'));
        }else{
            $data['styles'] = "[]";
        }

		$data['disable_ui'] = $this->config->get('tm_google_map_disable_ui');
		$data['scrollwheel'] = $this->config->get('tm_google_map_scrollwheel');
		$data['draggable'] = $this->config->get('tm_google_map_draggable');


        $markerWidth = $this->config->get('tm_google_map_marker_width');
        $markerHeight = $this->config->get('tm_google_map_marker_height');
        if (is_file(DIR_IMAGE .  $this->config->get('tm_google_map_marker'))){
		    $data['marker_image'] = $this->model_tool_image->resize($this->config->get('tm_google_map_marker'), $markerWidth, $markerHeight);
        }

        if (is_file(DIR_IMAGE .  $this->config->get('tm_google_map_marker_active'))){
            $data['marker_active_image'] = $this->model_tool_image->resize($this->config->get('tm_google_map_marker_active'), $markerWidth, $markerHeight);
        }

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/tm_google_map.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/tm_google_map.tpl', $data);
		} else {
			return $this->load->view('default/template/module/tm_google_map.tpl', $data);
		}
		
	}
	
}