<?php
//  Live Price 2 / Динамическое обновление цены - Живая цена 2
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru

// Heading
$_['module_name']         = 'Live Price 2';
$_['heading_title']       = 'LIVEOPENCART: '.$_['module_name'];
$_['text_edit']           = 'Edit '.$_['module_name'].' Module';

// Text
$_['text_module']         = 'Modules';
$_['text_success']        = 'Module "'.$_['heading_title'].'" successfully updated!';
$_['text_content_top']    = 'Content Top';
$_['text_content_bottom'] = 'Content Bottom';
$_['text_column_left']    = 'Column Left';
$_['text_column_right']   = 'Column Right';

$_['text_edit_position']  = 'Edit position';

// Entry
$_['entry_layout']        = 'Layout:';
$_['entry_position']      = 'Position:';
$_['entry_status']        = 'Status:';
$_['entry_sort_order']    = 'Sort Order:';
$_['entry_discount_quantity'] = 'Quantity for discounts:';
$_['text_discount_quantity_0'] = 'quantity per product';
$_['text_discount_quantity_1'] = 'quantity per product options combination';
$_['text_discount_quantity_2'] = 'quantity per product Related Options combination';
$_['entry_multiplied_price'] = 'Show price multiplied by quantity:';
$_['entry_about'] = 'About';
$_['entry_settings'] = 'Settings';

$_['entry_ignore_cart']      = 'Ignore cart quantity';
$_['entry_ignore_cart_help'] = 'Ignore product quantity already added to cart, on discount calculation';

$_['entry_calculate_once']      = 'Live Price: Calculate once';
$_['entry_calculate_once_help']      = 'Calculate this option price, weight, points at once. To be not multiplied by product quantity. ';

$_['entry_animation']      = 'Price changing animation';
$_['entry_animation_help']      = 'Fading animation, works not for all themes';

$_['text_success'] = 'Settings is modified!';
$_['text_update_alert']     = '(new version available)';

$_['text_relatedoptions_notify'] = 'Required extension: <a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=20902" target="_blank" title="Related Options for OpenCart">Related options</a>
or <a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=23143" target="_blank" title="Related Options PRO for OpenCart">Related options PRO</a>';

$_['module_description']    = 'The module is designed to dynamic price update on a product page, depending on the quantity and options currenly chosen by the customer. <br>
To get the available discounts the module uses total quantity: quantity from product page and product quantity already added to the cart (feature can be disabled).<br>
Price calculation for some options can be changed to "calculate once" (to be not dependent on product quantity), by checkbox on option edit page.
<br><br>
<span class="help">Required <a href="http://github.com/vqmod/vqmod" target="_blank">vQmod</a> version 2.6.1 or later.</span>';

$_['text_conversation'] = 'We are open for conversation. If you need modify or integrate our modules, add new functionality or develop new modules, email as to <b>support@liveopencart.com</b>.';

$_['entry_we_recommend'] = 'We also recommend:';
$_['entry_show_we_recommend'] = 'show';
$_['text_we_recommend'] = '
<strong>Live Price PRO</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=26295" target="_blank" title="Live Price PRO on opencart.com">opencart.com</a> )
<br>improved version of Live Price module, which allows not only to dynamic price update depending on selected options and quantity on product page, but also to set global discounts and specials, to set discounts and specials in percentage and more pricing features.
<br><br><strong>Related Options</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=20902" target="_blank" title="Related Options on opencart.com">opencart.com</a> )
<br>to create combinations of related product option values and set stock, price, model etc. for each combination. This functionality can be useful for sales of products, having interlinked options, such as size and color for clothes (recommended to use with Live Price module).
<br><br><strong>Related Options PRO</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=23143" target="_blank" title="Related Options PRO on opencart.com">opencart.com</a> )
<br>improved premium version or Related Options module, which allows to create different combinations of options values per one product.
<br><br><strong>Product Option Image PRO</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=21188" target="_blank" title="Product Option Image PRO on opencart.com">opencart.com</a> )
<br>to change main product image and list of additional images on product page depending on selected options (allows to set some images per option value).
<br><br><strong>Improved Options</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=22063" target="_blank" title="Improved Options on opencart.com">opencart.com</a> )
<br>to set SKU, model (product code, article), description for product option values and to set default values.
<br><br><strong>Parent-child Options</strong>&nbsp;&nbsp;( <a href="http://www.opencart.com/index.php?route=extension/extension/info&amp;extension_id=23337" target="_blank" title="Parent-child Options on opencart.com">opencart.com</a> )
<br>to show/hide child options (options groups) depending on selected parent options values.<br><br>
';

$_['module_copyright'] = '"'.$_['module_name'].'" is a commercial extension. Please do not resell or transfer it to other users. By purchasing this module, you get it for use on one site.<br> 
If you want to use the module on multiple sites, you should purchase a separate copy for each site. Thank you.';

$_['module_info'] = '"'.$_['module_name'].'" v %s | Developer: <a href="http://liveopencart.com" target="_blank">liveopencart.com</a> | Support: support@liveopencart.com | ';
$_['module_page'] = '<a href="http://www.opencart.com/index.php?route=extension/extension/info&extension_id=20835" target="_blank" title="Live Price on opencart.com">Live Price on opencart.com</a>';

// Error
$_['error_permission']    = 'Warning: You do not have permission to modify module "'.$_['heading_title'].'"!';
