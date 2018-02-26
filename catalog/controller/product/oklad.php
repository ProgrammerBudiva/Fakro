<?php
class ControllerProductOklad extends Controller
{
    public function index(){
        $this->load->model('catalog/product');
        $product_info = $this->model_catalog_product->getProduct(53);
        $product_options = $this->model_catalog_product->getProductOptions(53);
//        echo "<pre>"; print_r($product_info); echo "</pre>";
//        echo "<pre>"; print_r($product_options); echo "</pre>";
        $option = [ 253 => '93' ];
//        echo "<pre>"; print_r($option); echo "</pre>";
//        $this->cart->add(43, 1, $option, 0);
        $data = ['filter_category_id' => 73];
        $options = [];
        $products = $this->model_catalog_product->getProducts($data);
        foreach ($products as $product){
            $product_option = $this->model_catalog_product->getProductOptions($product['product_id']);
//            $options_get[$product['product_id']] =
//            echo "<pre>"; print_r($options_get[0]['product_option_value']); echo "</pre>";die;
//            $options[$product['product_id']] = ;
            foreach ($product_option[0]['product_option_value'] as $option){
                if ($option['name'] === '55*78' ){
                    $options_get[$product['product_id']] = ['price' => $option['price'], 'option_id' => $product_option[0]['product_option_id'], 'option_id_value' => $option['product_option_value_id']];
                    var_dump($option);continue;
                }
            }
        }
//        echo "<pre>"; print_r($products); echo "</pre>";
//        echo "<pre>"; print_r($options_get); echo "</pre>";
    }

    public function changeSize(){
        $this->load->model('catalog/product');

        $data = ['filter_category_id' => 73];
        $options_get = [];
        $products = $this->model_catalog_product->getProducts($data);
        foreach ($products as $product){
            $product_option = $this->model_catalog_product->getProductOptions($product['product_id']);
            foreach ($product_option[0]['product_option_value'] as $option){
                if ($option['name'] === $this->request->post['marker'] ){
                    $options_get[$product['product_id']] =
                        ['price' => $option['price'], 'option_id' => $product_option[0]['product_option_id'], 'option_id_value' => $option['product_option_value_id']];
                }
            }
        }
        echo json_encode(array('products' => $options_get));
    }
}