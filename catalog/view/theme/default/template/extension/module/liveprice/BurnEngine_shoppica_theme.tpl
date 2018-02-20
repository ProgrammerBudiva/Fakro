<?php if ($tbData['system.product_price']['show_label']): ?>
<span class="tb_label"><?php echo $tbData->text_price; ?></span>
<?php endif; ?>

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

<?php if (!$tbData['system.product_price']['show_tax']) $tax = false; ?>
<?php if ($tax) { ?>
<span class="price-tax"><?php echo $text_tax; ?> <span><?php echo $tax; ?></span></span>
<?php } ?>

<?php if (!$tbData['system.product_price']['show_reward']) $points = false; ?>
<?php if ($points) { ?>
<span class="reward"><?php echo $text_points; ?> <?php echo $points; ?></span>
<?php } ?>

<?php if ( !empty($liveprice_savings) /*$tbData->product_savings*/ && $tbData['system.product_price']['show_savings']): ?>
<p class="price-savings">
<?php if ($tbData['system.product_price']['show_savings_sum']): ?>
<?php echo sprintf($tbData->text_you_save,$liveprice_yousave);//$tbData->product_you_save; ?>
<?php else: ?>
<?php echo sprintf($tbData->text_product_savings,$liveprice_savings);//$tbData->product_savings; ?>
<?php endif; ?>
</p>
<?php endif; ?>
<?php /*
<?php if ($price): ?>
<?php if ($discounts) { ?>
<?php if ($tbData['system.product_discounts']['block_title']): ?>
<div class="panel-heading">
  <h2 class="panel-title"><?php echo $tbData->text_product_discount; ?></h2>
</div>
<?php endif; ?>
<div class="panel-body">
  <table{{table_classes}}>
    <thead>
      <tr>
        <th><?php echo $tbData->text_product_order_quantity; ?></th>
        <th><?php echo $tbData->text_product_price_per_item; ?></th>
      </tr>
    </thead>
    <tbody>
      <?php foreach ($discounts as $discount): ?>
      <tr>
        <td><?php echo sprintf($tbData->text_product_discount_items, $discount['quantity']); ?></td>
        <td><?php echo $discount['price']; ?></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
</div>
<?php } ?>
<?php endif; ?>
*/ ?>