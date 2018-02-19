<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-ocfilter" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary" onclick="$('#form-ocfilter').attr('action','<?php echo $save; ?>');"><i class="fa fa-save"></i></button>
        <button type="submit" form="form-ocfilter" data-toggle="tooltip" title="<?php echo $button_apply; ?>" class="btn btn-success" onclick="$('#form-ocfilter').attr('action','<?php echo $apply; ?>');"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a>
			</div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-exclamation-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="" method="post" enctype="multipart/form-data" id="form-ocfilter" class="form-horizontal">
          <div role="tabs">
            <ul class="nav nav-tabs" role="tablist">
              <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
              <li><a href="#tab-option" data-toggle="tab"><?php echo $tab_option; ?></a></li>
              <li><a href="#tab-price-filtering" data-toggle="tab"><?php echo $tab_price_filtering; ?></a></li>
              <li><a href="#tab-other" data-toggle="tab"><?php echo $tab_other; ?></a></li>
              <li><a href="#tab-copy" data-toggle="tab">Копирование фильтров</a></li>
            </ul>

          	<div class="tab-content">
              <div id="tab-general" class="tab-pane active">
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-status"><?php echo $entry_status; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_status" id="input-status" class="form-control">
                      <?php if ($ocfilter_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_status; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-sitemap-status">Sitemap посадочных страниц фильтра</label>
                  <div class="col-sm-9">
                    <select name="ocfilter_sitemap_status" id="input-sitemap-status" onchange="$('#sitemap-link').collapse(this.value > 0 ? 'show' : 'hide');" class="form-control">
                      <?php if ($ocfilter_sitemap_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>

                <div class="collapse" id="sitemap-link">
                  <div class="form-group">
                    <label class="col-sm-3 control-label">Ссылка на Sitemap</label>
                    <div class="col-sm-9"><mark><?php echo $sitemap_link; ?></mark></div>
                  </div>
                </div>
  		        </div>
  		        <div id="tab-option" class="tab-pane">
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-selected"><?php echo $entry_show_selected; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_show_selected" id="input-show-selected" class="form-control">
                      <?php if ($ocfilter_show_selected) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_show_selected; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-price"><?php echo $entry_show_price; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_show_price" id="input-show-price" class="form-control">
                      <?php if ($ocfilter_show_price) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_show_price; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-counter"><?php echo $entry_show_counter; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_show_counter" id="input-show-counter" class="form-control">
                      <?php if ($ocfilter_show_counter) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_show_counter; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-manufacturer"><?php echo $entry_manufacturer; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_manufacturer" id="input-manufacturer" onchange="$('#manufacturer-type').collapse(this.value > 0 ? 'show' : 'hide');" class="form-control">
                      <?php if ($ocfilter_manufacturer) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_manufacturer; ?></p>
                  </div>
                </div>

                <div class="collapse" id="manufacturer-type">
                  <div class="form-group">
                    <label class="col-sm-3 control-label" for="input-manufacturer-type"><?php echo $entry_type; ?></label>
                    <div class="col-sm-9">
                      <select name="ocfilter_manufacturer_type" id="input-manufacturer-type" class="form-control">
                        <?php foreach ($types as $type) { ?>
                        <?php if ($type == $ocfilter_manufacturer_type) { ?>
                        <option value="<?php echo $type; ?>" selected="selected"><?php echo ucfirst($type); ?></option>
                        <?php } else { ?>
                        <option value="<?php echo $type; ?>"><?php echo ucfirst($type); ?></option>
                        <?php } ?>
                        <?php } ?>
                      </select>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-stock-status"><?php echo $entry_stock_status; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_stock_status" id="input-stock-status" onchange="if (this.value > 0) { $('#stock-status-method').collapse('show'); } else { $('#stock-status-method').collapse('hide'); }; $('select[name=\'ocfilter_stock_status_method\']').trigger('change');" class="form-control">
                      <?php if ($ocfilter_stock_status) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_stock_status; ?></p>
                  </div>
                </div>

                <div class="collapse" id="stock-status-method">
                  <div class="form-group">
                    <label class="col-sm-3 control-label" for="input-stock-status-method"><?php echo $entry_stock_status_method; ?></label>
                    <div class="col-sm-9">
                      <select name="ocfilter_stock_status_method" id="input-stock-status-method" onchange="$('#stock-status-quantity').collapse(this.value == 'quantity' ? 'show' : 'hide'); $('#stock-status-id').collapse(this.value == 'quantity' ? 'hide' : 'show');" class="form-control">
                        <?php if ($ocfilter_stock_status_method == 'quantity') { ?>
                        <option value="quantity" selected="selected"><?php echo $text_stock_by_quantity; ?></option>
                        <option value="stock_status_id"><?php echo $text_stock_by_status_id; ?></option>
                        <?php } else { ?>
                        <option value="quantity"><?php echo $text_stock_by_quantity; ?></option>
                        <option value="stock_status_id" selected="selected"><?php echo $text_stock_by_status_id; ?></option>
                        <?php } ?>
                      </select>
                    </div>
                  </div>

                  <div class="collapse" id="stock-status-id">
                    <div class="form-group">
                      <label class="col-sm-3 control-label" for="input-stocks-tatus-type"><?php echo $entry_type; ?></label>
                      <div class="col-sm-9">
                        <select name="ocfilter_stock_status_type" id="input-stocks-tatus-type" class="form-control">
                          <?php foreach ($types as $type) { ?>
                          <?php if ($type == $ocfilter_stock_status_type) { ?>
                          <option value="<?php echo $type; ?>" selected="selected"><?php echo ucfirst($type); ?></option>
                          <?php } else { ?>
                          <option value="<?php echo $type; ?>"><?php echo ucfirst($type); ?></option>
                          <?php } ?>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                  </div>

                  <div class="collapse" id="stock-status-quantity">
                    <div class="form-group">
                      <label class="col-sm-3 control-label" for="input-stock-out-value"><?php echo $entry_stock_out_value; ?></label>
                      <div class="col-sm-9">
                        <select name="ocfilter_stock_out_value" id="input-stock-out-value" class="form-control">
                          <?php if ($ocfilter_stock_out_value) { ?>
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                        </select>
                      </div>
                    </div>
                  </div>
                </div>
  		        </div>
  		        <div id="tab-price-filtering" class="tab-pane">
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-diagram"><?php echo $entry_show_diagram; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_show_diagram" id="input-show-diagram" class="form-control">
                      <?php if ($ocfilter_show_diagram) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_show_diagram; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-manual-price"><?php echo $entry_manual_price; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_manual_price" id="input-manual-price" class="form-control">
                      <?php if ($ocfilter_manual_price) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_manual_price; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-consider-discount"><?php echo $entry_consider_discount; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_consider_discount" id="input-consider-discount" class="form-control">
                      <?php if ($ocfilter_consider_discount) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_consider_discount; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-consider-special"><?php echo $entry_consider_special; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_consider_special" id="input-consider-special" class="form-control">
                      <?php if ($ocfilter_consider_special) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_consider_special; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-consider-option"><?php echo $entry_consider_option; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_consider_option" id="input-consider-option" class="form-control">
                      <?php if ($ocfilter_consider_option) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_consider_option; ?></p>
                  </div>
                </div>
  		        </div>
  		        <div id="tab-other" class="tab-pane">
                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-options-limit"><?php echo $entry_show_first_limit; ?></label>
                  <div class="col-sm-4">
                    <div class="input-group">
                      <input type="number" name="ocfilter_show_options_limit" min="0" value="<?php echo $ocfilter_show_options_limit; ?>" class="form-control" id="input-show-options-limit" />
                      <span class="input-group-addon"><?php echo $text_options; ?></span>
                    </div><!-- /.input-group -->
                    <p class="help-block"><?php echo $notice_show_options_limit; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-show-values-limit"><?php echo $entry_show_first_limit; ?></label>
                  <div class="col-sm-4">
                    <div class="input-group">
                      <input type="number" name="ocfilter_show_values_limit" min="0" value="<?php echo $ocfilter_show_values_limit; ?>" class="form-control" id="input-show-values-limit" />
                      <span class="input-group-addon"><?php echo $text_values; ?></span>
                    </div><!-- /.input-group -->
                    <p class="help-block"><?php echo $notice_show_values_limit; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-hide-empty-values"><?php echo $entry_hide_empty_values; ?></label>
                  <div class="col-sm-9">
                    <select name="ocfilter_hide_empty_values" id="input-hide-empty-values" class="form-control">
                      <?php if ($ocfilter_hide_empty_values) { ?>
                      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                      <option value="0"><?php echo $text_disabled; ?></option>
                      <?php } else { ?>
                      <option value="1"><?php echo $text_enabled; ?></option>
                      <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                      <?php } ?>
                    </select>
                    <p class="help-block"><?php echo $notice_hide_empty_values; ?></p>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-noindex-limit"><?php echo $entry_noindex_limit; ?></label>
                  <div class="col-sm-4">
                    <div class="input-group">
                      <input type="number" name="ocfilter_noindex_limit" min="0" value="<?php echo $ocfilter_noindex_limit; ?>" class="form-control" id="input-show-values-limit" />
                      <span class="input-group-addon"><?php echo $text_values; ?></span>
                    </div><!-- /.input-group -->
                    <p class="help-block"><?php echo $notice_noindex_limit; ?></p>
                  </div>
                </div>
  		        </div>

  		        <div id="tab-copy" class="tab-pane">
                <div class="form-group">
                  <label class="col-sm-3 control-label"><?php echo $entry_store; ?></label>
                  <div class="col-sm-9">
                    <div class="well" style="overflow: auto; max-height: 100px;">
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="copy_store[]" value="0" checked="checked" /> Основной магазин
                        </label>
                      </div>
		                  <?php foreach ($stores as $store) { ?>
                      <div class="checkbox">
                        <label>
                          <input type="checkbox" name="copy_store[]" value="<?php echo $store['store_id']; ?>" /> <?php echo $store['name']; ?>
                        </label>
                      </div>
		                  <?php } ?>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-copy-type"><?php echo $entry_type; ?></label>
                  <div class="col-sm-9">
                    <select name="copy_type" id="input-copy-type" class="form-control">
                      <?php foreach ($types as $type) { ?>
                      <option value="<?php echo $type; ?>"><?php echo ucfirst($type); ?></option>
                      <?php } ?>
                    </select>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-truncate">Очистить существующие фильтры OCFilter</label>
                  <div class="col-sm-9">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="copy_truncate" value="1" id="input-truncate" />
                      </label>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-copy-attribute">Копировать атрибуты</label>
                  <div class="col-sm-4">
                    <div class="input-group">
                      <span class="input-group-addon">
                        <input type="checkbox" name="copy_attribute" value="1" id="input-copy-attribute" />
                      </span>
                      <input name="ocfilter_attribute_separator" type="text" class="form-control" placeholder="Разделитель атрибутов" value="<?php echo $ocfilter_attribute_separator; ?>" />
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-copy-filter">Копировать стандартные фильтры</label>
                  <div class="col-sm-9">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="copy_filter" value="1" id="input-copy-filter" />
                      </label>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <label class="col-sm-3 control-label" for="input-copy-option">Копировать опции товаров</label>
                  <div class="col-sm-9">
                    <div class="checkbox">
                      <label>
                        <input type="checkbox" name="copy_option" value="1" id="input-copy-option" />
                      </label>
                    </div>
                  </div>
                </div>

                <div class="form-group">
                  <div class="col-sm-offset-3 col-sm-9">
                    <button type="button" class="btn btn-lg btn-primary" id="button-copy-filter" data-loading-text="<?php echo $text_loading; ?>" data-complete-text="<?php echo $text_complete; ?>"><i class="fa fa-copy"></i> Копировать</button>
                  </div>
                </div>
  		        </div>
            </div>
          </div>
        </form>
			</div>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
  $('select[onchange]').trigger('change');

  var timer;

  $('#button-copy-filter').on('click', function(e) {
    clearTimeout(timer);

    $('#tab-copy > .alert').remove();

    var button = $(this).button('loading');

    $.post('index.php?route=module/ocfilter/copyFilters&token=<?php echo $token; ?>', $('[name^=\'copy_\'], [name=\'ocfilter_attribute_separator\']').serialize(), function(response) {
      if (response['error']) {
        button.button('reset');

        $('#tab-copy').prepend('<div class="alert alert-danger" role="alert">' + response['error'] + '</div>');
      }

      if (response['success']) {
        button.button('complete');

        $('#tab-copy').prepend('<div class="alert alert-success" role="alert">' + response['success'] + '</div>');

        timer = setTimeout(function() {
          button.button('reset');
        }, 10 * 1000);
      }
    }, 'json');
  });
//--></script>
<?php echo $footer; ?>