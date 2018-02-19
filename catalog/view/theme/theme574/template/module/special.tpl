<div class="box specials">
	<div class="box-heading"><h3><?php echo $heading_title; ?></h3></div>
	<div class="box-content">
			<div class="row">
			<?php $t=0; foreach ($products as $product) { $t++ ?>
			<div class="product-layout col-lg-3 col-md-3 col-sm-3 col-xs-12">
				<div class="product-thumb transition">
					
				<div class="quick_info">
					<div id="quickview_specials_<?php echo $t?>">
						<div>
							<div class="left col-sm-4">
								<div class="quickview_image image"><a href="<?php echo $product['href']; ?>"><img alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" src="<?php echo $product['thumb']; ?>" /></a></div>
								</div>
								<div class="right col-sm-8">
									<h2><?php echo $product['name']; ?></h2>
									<div class="inf">
										<?php if ($product['author']) {?>
											<p class="quickview_manufacture manufacture manufacture"><?php echo $text_manufacturer; ?> <a href="<?php echo $product['manufacturers'];?>"><?php echo $product['author']; ?></a></p>
										<?php }?>
										<?php if ($product['model']) {?>
											<p class="product_model model"><?php echo $text_model; ?> <?php echo $product['model']; ?></p>
										<?php }?>

										<?php if ($product['price']) { ?>
										<div class="price">
										<?php if (!$product['special']) { ?>
										<?php echo $product['price']; ?>
										<?php } else { ?>
										<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
										<?php } ?>
										<?php if ($product['tax']) { ?>
										<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
										<?php } ?>
										</div>
										<?php } ?>
									</div>
									<div class="cart-button">
										<button class="btn btn-icon btn-add" data-toggle="tooltip" title="<?php echo $button_cart; ?>" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');"><i class="material-design-shopping231"></i></button><button class="btn btn-icon" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="material-design-favorite22"></i></button><button class="btn btn-icon" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="material-design-shuffle24"></i></button>
									</div>
									<div class="clear"></div>
									<div class="rating">
										<?php for ($i = 1; $i <= 5; $i++) { ?>
										<?php if ($product['rating'] < $i) { ?>
										<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
										<?php } else { ?>
										<span class="fa fa-stack"><i class="fa fa-star active fa-stack-2x"></i></span>
										<?php } ?>
										<?php } ?>
									</div>
										
								</div>
								<div class="col-sm-12">
									<div class="quickview_description description">
										<?php echo $product['description1'];?>
									</div>
								</div>
						</div>
					</div>
				</div>				
					
					<div class="image">
						<a class="lazy" style="padding-bottom: <?php echo ($product['img-height']/$product['img-width']*100); ?>%" href="<?php echo $product['href']; ?>"> <img alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" class="img-responsive" data-src="<?php echo $product['thumb']; ?>" src="#"/>
						</a>
						
						<div class="stickers">
						<?php
						$arr_last = $product['last_array'];
						foreach( $arr_last as $value ){
							if ($product['product_id']==$value) { ?>
								<div class="new_pr"><?php echo $text_new; ?></div>
								<?php }
							}
						?>
						<?php if ($product['special']) { ?>
							<div class="sale"><?php echo $text_sale; ?></div>			
						<?php } ?>
						</div>	
						
					</div>
					<div class="caption">
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>				
						
						<?php if ($product['price']) { ?>
						<div class="price">
						<?php if (!$product['special']) { ?>
						<?php echo $product['price']; ?>
						<?php } else { ?>
						<span class="price-new"><?php echo $product['special']; ?></span> <span class="price-old"><?php echo $product['price']; ?></span>
						<?php } ?>
						<?php if ($product['tax']) { ?>
						<span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
						<?php } ?>
						</div>
						<?php } ?>
					</div>
					<div class="cart-button">
						<button class="product-btn-add" type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');">
							<i class="material-design-shopping231"></i> <span class="hidden-sm"><?php echo $button_cart; ?></span>
						</button>
						<div class="row">
						<button class="product-btn" type="button" data-toggle="tooltip" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product['product_id']; ?>');"><i class="material-design-favorite22"></i></button>
						<button class="product-btn" type="button" data-toggle="tooltip" title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product['product_id']; ?>');"><i class="material-design-shuffle24"></i></button>				
						<a class="quickview product-btn" data-toggle="tooltip" data-rel="details" href="#quickview_specials_<?php echo $t?>"  title="<?php echo $text_quick; ?>"><i class="material-design-tick7"></i></a>
						</div>
						
						<div class="rating">
						<?php for ($i = 1; $i <= 5; $i++) { ?>
						<?php if ($product['rating'] < $i) { ?>
						<span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i></span>
						<?php } else { ?>
						<span class="fa fa-stack"><i class="fa fa-star active fa-stack-2x"></i></span>
						<?php } ?>
						<?php } ?>
						</div>
						
					</div>
				</div>
			</div>
			<?php } ?>
			</div>
	</div>
</div>