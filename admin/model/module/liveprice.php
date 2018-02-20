<?php
//  Live Price 2 / Динамическое обновление цены - Живая цена 2
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

class ModelModuleLivePrice extends Model {

  public function installed() {
    
    $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "extension WHERE `type` = 'module' AND `code` = 'liveprice'");
    
    return $query->num_rows;
  }

  
  public function current_version() {
    
    return '2.2.1';
    
  }

}

