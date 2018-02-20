<?php
//  Live Price 2 / Динамическое обновление цены - Живая цена 2
//  Support: support@liveopencart.com / Поддержка: help@liveopencart.ru
?>
<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	
	<div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-liveprice" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $module_name; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
	<div class="container-fluid">
    <?php if (isset($error_warning) && $error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		
		<?php if (isset($success) && $success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
		<div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
				
				<ul class="nav nav-tabs">
					<li class="active"><a href="#tab-settings" data-toggle="tab"><?php echo $entry_settings; ?></a></li>
					<li><a href="#tab-about" data-toggle="tab" id="tab-about-button"><?php echo $entry_about; ?></a></li>
				</ul>
				
				<div class="tab-content">
          <div class="tab-pane active" id="tab-settings" style="min-height: 300px;">
				
						
						
						
						
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-liveprice" class="form-horizontal">
						
							<div class="form-group">
								<label class="col-sm-2 control-label" for="animation">
									<span data-toggle="tooltip" title="<?php echo $entry_animation_help; ?>">
										<?php echo $entry_animation; ?>
									</span>
								</label>
								<div class="col-sm-10">
									
									<div class="checkbox">
										<label>
											<input type="checkbox" name="liveprice_settings[animation]" id="animation" value="1" <?php if (isset($liveprice_settings['animation']) && $liveprice_settings['animation']) echo "checked"; ?> >
										</label>
									</div>
								
								</div>
							</div>
						
							<div class="form-group">
								<label class="col-sm-2 control-label" for="ignore_cart">
									<span data-toggle="tooltip" title="<?php echo $entry_ignore_cart_help; ?>">
										<?php echo $entry_ignore_cart; ?>
									</span>
								</label>
								<div class="col-sm-10">
									
									<div class="checkbox">
										<label>
											<input type="checkbox" name="liveprice_settings[ignore_cart]" id="ignore_cart" value="1" <?php if (isset($liveprice_settings['ignore_cart']) && $liveprice_settings['ignore_cart']) echo "checked"; ?> >
										</label>
									</div>
								
								</div>
							</div>
						
							<div class="form-group">
								<label class="col-sm-2 control-label" for="multiplied_price"><?php echo $entry_multiplied_price; ?></label>
								<div class="col-sm-10">
									
									<div class="checkbox">
										<label>
											<input type="checkbox" name="liveprice_settings[multiplied_price]" id="multiplied_price" value="1" <?php if (isset($liveprice_settings['multiplied_price']) && $liveprice_settings['multiplied_price']) echo "checked"; ?> >
										</label>
									</div>
								
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-2 control-label" for="discount_quantity"><?php echo $entry_discount_quantity; ?></label>
								<div class="col-sm-10">
									
									<select id="discount_quantity" name="liveprice_settings[discount_quantity]" class="form-control">
										<option value="0" <?php if ($liveprice_settings['discount_quantity']==0) echo "selected"; ?> ><?php echo $text_discount_quantity_0; ?></option>
										<option value="1" <?php if ($liveprice_settings['discount_quantity']==1) echo "selected"; ?> ><?php echo $text_discount_quantity_1; ?></option>
										<option value="2" <?php if ($liveprice_settings['discount_quantity']==2) echo "selected"; ?> ><?php echo $text_discount_quantity_2; ?></option>
									</select>
									
									<span class="help-block" style="display: none;" id="text_relatedoptions_notify"><?php echo $text_relatedoptions_notify; ?></span>
								
								</div>
							</div>
							
							
						</form>
						
						
						
					</div>
					
					<div class="tab-pane" id="tab-about" style="min-height: 300px;">
						
						<div id="module_description">
							<?php echo $module_description; ?>
						</div>
						<hr>
						<?php echo $text_conversation; ?>
						<hr>
						<br>
						<h4><?php echo $entry_we_recommend; ?></h4><br>
						<div id="we_recommend">
							<?php echo $text_we_recommend; ?>
						</div>	
						
						<hr>
						
					</div>
					
				</div>	
				
				<?php echo sprintf($module_info, $module_version); ?><span id="module_page"><?php echo $module_page; ?></span><span class="help-block" style="font-size: 80%; line-height: 130%;"><?php echo $module_copyright; ?></span>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript"><!--

function checkRelatedOptionsNotify() {
	
	if ( $('#discount_quantity').val() == "2" ) {
		$('#text_relatedoptions_notify').show();
	} else {
		$('#text_relatedoptions_notify').hide();
	}
	
}

$(document).ready(function(){
	
	$('#discount_quantity').change(function(){
		checkRelatedOptionsNotify();
	});
	
	checkRelatedOptionsNotify();
	
});


//--></script>


<script type="text/javascript"><!--

	function check_for_updates() {
		
		$.ajax({
			url: window.location.protocol+'//update.liveopencart.com/upd.php',
			type: 'post',
			data: {module:'lp2', version:'<?php echo $module_version; ?>', lang: '<?php echo $config_admin_language; ?>'},
			dataType: 'json',
	
			success: function(data) {
				
				if (data) {
					
					if (data['recommend']) {
						$('#we_recommend').html(data['recommend']);
					}
					if (data['update']) {
						$('#tab-about-button').append('&nbsp;&nbsp;<font style="color:red;font-weight:normal;"><?php echo addslashes($text_update_alert); ?></font>');
						$('#module_description').after('<hr><div class="alert alert-info" role="alert">'+data['update']+'</div>');
					}
					if (data['product_pages']) {
						$('#module_page').html(data['product_pages']);
					}
				}
			}
		});
		
	}

	check_for_updates();

//--></script>

<?php echo $footer; ?>