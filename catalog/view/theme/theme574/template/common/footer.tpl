<footer>
	<?php if ($footer_top) { ?>
	<div class="footer">
		<?php if ($maintenance == 0){ ?>
				<?php echo $footer_top; ?>
			<?php } ?>
	</div>
	<?php } ?>
  <div class="container">
	<div class="row">
		<div class="col-sm-3">			
			<?php if ($logo) { ?>
			<div class="logo">
			    <a href="<?php echo $home; ?>"><img src="/image/catalog/logo-fakro-ua-подвал.png" alt="" class="img-responsive" /></a>
                <div style="margin-top: 9px; font-size: 13px;line-height:15px;">
                    Мансардные окна FAKRO <br> с доставкой по всей Украине <br> от официального дилера
                </div>
			</div>
			<?php } ?>
			<!--<div class="footer_box">
				<ul class="list-unstyled social">
					<li><a data-toggle="tooltip" title="<?php echo $text_fb; ?>" href="https://www.facebook.com/login/"><i class="fa fa-facebook"></i></a></li>
					<li><a data-toggle="tooltip" title="<?php echo $text_twi; ?>" href="https://twitter.com/"><i class="fa fa-twitter"></i></a></li>
					<li><a data-toggle="tooltip" title="<?php echo $text_google; ?>" href="https://accounts.google.com/"><i class="fa fa-google-plus"></i></a></li>
				</ul>
			</div>-->
			
		</div>
        <div class="col-sm-3 cast">
            <div class="footer_box">
                <div class="call_me toggle-wrap">
                    <div class="footer-call-me">
                        <input type="text" class="footer-call-me-input" id="footer-phone" placeholder="+38 (___) ___-__-__">
                    </div>
                    <div class="call_me_div" id="phone_me">
                        <span >Перезвоните мне</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3 cast" style="margin-top: 18px;">
            <div class="footer_box">
                <div class=" toggle-wrap  phone-number">
			        <span style="font-size: 23px; letter-spacing: -1px; font-weight: 400;">
                        <i class="material-design-phone370" style="color:#3aa935;"></i>
                        (800) 300 506
			        </span>
                </div>
                <div class="free-phone">звонок бесплатный</div>
                <div class="mail">info@fakro.pro</div>
            </div>
        </div>
		<div class="col-sm-2 cast" style="margin-top: 3px;">

        <?php foreach($data['categories'] as $category){ ?>
            <div class="footer_box">
                <h6><a href="<?php echo $category['link']; ?>"><?php echo $category['name']; ?></a></h6>
            </div>
        <?php } ?>
	</div>
  </div>
	<div class="copyright">
		<!--<div class="container">
			<hr>
			<span class="powered"><?php echo $powered; ?></span>
			<a class="site-logo" href="http://www.templatemonster.com/" rel="nofollow" target="_blank"><img src="image/catalog/site-logo.png" alt="logo"></a>
		</div> -->
	</div>
</footer>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/livesearch.js" type="text/javascript"></script>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/script.js" type="text/javascript"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.13/jquery.mask.min.js"></script>
<script>
    $('#footer-phone').mask("+38 (999) 999-99-99");
    $('.phone-input').mask("+38 (999) 999-99-99");

    $('#send_phone').click(function(){
//        $('.phone-input').addClass('has-error');
        var phone = $('.phone-input').removeClass('has-error').val();
        if(phone.length === 0){
            $('.phone-input').addClass('has-error');
        }else{
            $.ajax({
                url: 'index.php?route=common/header/callback',
                method: "post",
                data:{callback_phone: phone},
                success: function () {
                    $('.phone-input').hide().val('');
                    $('#send_phone').html('Отправлено!');

                    setTimeout(function () {
                        $('#demo').removeClass('in');
                        $('.phone-input').show().val('');
                        $('#send_phone').html('Отправить');
                    }, 2000);

                }
            });
        }
    });

    $('#phone_me').click(function(){
//        $('.phone-input').addClass('has-error');
        var phone = $('#footer-phone').removeClass('has-error').val();
        if(phone.length === 0){
            $('#footer-phone').addClass('has-error');
        }else{
            $.ajax({
                url: 'index.php?route=common/header/callback',
                method: "post",
                data:{callback_phone: phone},
                success: function () {
                    $('#footer-phone').hide().val('');
                    $('#phone_me span').html('Отправлено!');

                    setTimeout(function () {
                        $('#footer-phone').show().val('');
                        $('#phone_me span').html('Отправить');
                    }, 2000);

                }
            });
        }
    });

    $('#search-2').click(function(){
       $('#search').toggleClass('active-gadget');
    });
</script>
</div>

</body></html>