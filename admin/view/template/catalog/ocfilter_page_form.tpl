<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-information" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> Форма страницы OCFilter</h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-information" class="form-horizontal">
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-title">Название (H1)</label>
            <div class="col-sm-10">
              <input type="text" name="title" value="<?php echo $title; ?>" placeholder="Название (H1)" id="input-title" class="form-control" required />
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-category">Категория</label>
            <div class="col-sm-10">
              <input type="text" name="category" value="<?php echo $category ?>" placeholder="Введите название категории" id="input-category" class="form-control" />
              <input type="hidden" name="category_id" value="<?php echo $category_id; ?>" />
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-ocfilter-params">Параметры фильтра</label>
            <div class="col-sm-10">
              <input type="text" name="ocfilter_params" value="<?php echo $ocfilter_params; ?>" placeholder="Например proizvoditel:dewalt/moschnost-dvigatelja-bolgarki:do-850" id="input-ocfilter-params" class="form-control" required />
              <span class="help-block text-warning">Здесь только параметры фильтра! Без категории!</span>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-description">SEO Текст</label>
            <div class="col-sm-10">
              <textarea name="description" placeholder="SEO Текст" id="input-description" class="form-control"><?php echo $description; ?></textarea>
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-meta-title">Meta Title</label>
            <div class="col-sm-10">
              <input type="text" name="meta_title" value="<?php echo $meta_title; ?>" placeholder="Meta Title" id="input-meta-title" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-meta-description">Meta Description</label>
            <div class="col-sm-10">
              <textarea name="meta_description" rows="5" placeholder="Meta Description" id="input-meta-description" class="form-control"><?php echo $meta_description; ?></textarea>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-meta-keyword">Meta Keyword</label>
            <div class="col-sm-10">
              <textarea name="meta_keyword" rows="5" placeholder="Meta Keyword" id="input-meta-keyword" class="form-control"><?php echo $meta_keyword; ?></textarea>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-keyword">SEO URL</label>
            <div class="col-sm-10">
              <input type="text" name="keyword" value="<?php echo $keyword; ?>" id="input-keyword" class="form-control" />
              <span class="help-block">Должен быть уникальным на всю систему</span>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status">Статус</label>
            <div class="col-sm-10">
              <select name="status" id="input-status" class="form-control">
                <?php if ($status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
  $('#input-description').summernote({
  	height: 300
  });

  // Category
  $('input[name=\'category\']').autocomplete({
  	'source': function(request, response) {
  		$.ajax({
  			url: 'index.php?route=catalog/category/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request),
  			dataType: 'json',
  			success: function(json) {
  				json.unshift({
  					category_id: 0,
   					name: 'Не указано'
   				});

  				response($.map(json, function(item) {
  					return {
  						label: item['name'],
  						value: item['category_id']
  					}
  				}));
  			}
  		});
  	},
  	'select': function(item) {
  		$('input[name=\'category\']').val(item['label']);
  		$('input[name=\'category_id\']').val(item['value']);
  	}
  });
  //--></script>
</div>
<?php echo $footer; ?>