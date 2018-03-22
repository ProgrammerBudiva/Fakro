<?php echo $header; ?>

<div class="container">
    <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
    </ul>
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="errors"></div>
    <div class="row" style="margin: 0;">
        <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
            <h1><?php echo $heading_title; ?></h1>
            <div class="panel-body checkout_row">
                <form action="" id="order-form">
                <div class="row">
                    <div class="col-sm-6">
                        <fieldset id="account">
                            <legend>Личные данные</legend>
                            <div class="form-group" style="display: none;">
                                <label class="control-label">Тип бизнеса</label>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="customer_group_id" value="1" checked="checked" />
                                        Default</label>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="input-payment-firstname">Имя</label>
                                <input type="text" name="firstname" value="" placeholder="Имя" id="input-payment-firstname" class="form-control" />
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="input-payment-lastname">Фамилия</label>
                                <input type="text" name="lastname" value="" placeholder="Фамилия" id="input-payment-lastname" class="form-control" />
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="input-payment-email">E-Mail</label>
                                <input type="text" name="email" value="" placeholder="E-Mail" id="input-payment-email" class="form-control" />
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="input-payment-telephone">Телефон</label>
                                <input type="text" name="telephone" value="" placeholder="Телефон" id="input-payment-telephone" class="form-control" />
                            </div>
                        </fieldset>
                    </div>
                    <div class="col-sm-6">
                        <fieldset id="address">
                            <legend>Оплата моего заказа</legend>
                            <div class="form-group required">
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="payment_method" value="1"  />Предоплата через Приват24
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="payment_method" value="2" />Наложенный платеж (доп. +2% услуги Новой Почты)
                                    </label>
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input type="radio" name="payment_method" value="3" />Оплата по счёту с НДС (безналичный расчет)
                                    </label>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="input-payment-address-1">Адрес доставки</label>
                                <textarea type="text" name="address_1" value="" placeholder="Адрес" id="input-payment-address-1" class="form-control"></textarea>
                            </div>
                            <div class="form-group required">
                                <label class="control-label" for="comment">Комментарий к заказу</label>
                                <textarea type="text" name="comment" value="" placeholder="Комментарий" id="comment" class="form-control"></textarea>
                            </div>
                        </fieldset>
                    </div>
                </div>
                </form>
                <div class="buttons">
                    <div class="pull-right">
                        <input type="button" value="Подтверждение заказа" id="button-confirm" data-loading-text="Загрузка..." class="btn btn-primary" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<a href="#succes-popup" id="" class="btn btn-primary next-btn delivery-continue-popup" style="visibility: hidden" data-effect="mfp-zoom-in"></a>
<div id="succes-popup" class="white-popup mfp-with-anim mfp-hide"></div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/magnific-popup.js/1.1.0/jquery.magnific-popup.min.js"></script>
<script>

    $('.delivery-continue-popup').magnificPopup({
        removalDelay:500,
        callbacks:{beforeOpen:function(){this.st.mainClass=this.st.el.attr('data-effect');}},
        midClick:true
    });

    $('#button-confirm').click(function(){
        $('.alert-danger').remove();

        var data = $('#order-form').serialize();
        $.ajax({
            url: 'index.php?route=checkout/confirm1',
            data: data,
            type: 'post',
            success: function (json) {
                if(json.error){
                    $.each(json.error, function (i) {
                        $('.errors').after().append('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>' + json.error[i] +'</div>')
                    });
                    $('html,body').animate({
                            scrollTop: $(".errors").offset().top},
                        'slow');
                }else if (json.success){
                    $('a.delivery-continue-popup').trigger('click');
                    $('#succes-popup').load(json.success);
                }
            }
        });
    });

</script>
<?php echo $footer; ?>