<div class="price">
  <?php $price = $tbData->priceFormat($price); ?>
  <?php if (!$special) { ?>
  <span class="price-regular"><?php echo $price; ?></span>
  <?php } else { ?>
  <?php $special = $tbData->priceFormat($special); ?>
  <span class="price-old"><?php echo $price; ?></span>
  <?php if ($tbData['system.product_price']['old_price_new_line']): ?>
  <span class="clear"></span>
  <?php endif; ?>
  <span class="price-new"><?php echo $special; ?></span>
  <?php } ?>
</div>