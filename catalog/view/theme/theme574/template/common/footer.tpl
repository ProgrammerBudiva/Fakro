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
			<a href="<?php echo $home; ?>"><img src="image/catalog/footer-logo.png" alt="" class="img-responsive" /></a>
			</div>
			<?php } ?>
			<div class="footer_box">
				<ul class="list-unstyled social">
					<li><a data-toggle="tooltip" title="<?php echo $text_fb; ?>" href="https://www.facebook.com/login/"><i class="fa fa-facebook"></i></a></li>	
					<li><a data-toggle="tooltip" title="<?php echo $text_twi; ?>" href="https://twitter.com/"><i class="fa fa-twitter"></i></a></li>
					<li><a data-toggle="tooltip" title="<?php echo $text_google; ?>" href="https://accounts.google.com/"><i class="fa fa-google-plus"></i></a></li>
				</ul>
			</div>
			
		</div>
        <div class="col-sm-3 cast">
            <div class="footer_box">
                <div class="call_me toggle-wrap">
                    <div class="footer-call-me">
                    <input type="text" class="footer-call-me-input" id="footer-phone" placeholder="(XXX) XXX-XX-XX">
                    </div>
                    <div class="call_me_div">
                        <span>Перезвоните мне</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-3 cast">
            <div class="footer_box">
                <div class=" toggle-wrap search phone-number">
			        <span style="font-size: 23px; letter-spacing: -1px; font-weight: 400;">
                        <i class="material-design-phone370" style="color:#3aa935;"></i>
                        (800) 300 506
			        </span>
                </div>
            </div>
        </div>
		<div class="col-sm-2 cast">

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
    $('#footer-phone').mask("(999) 999-99-99");
</script>
</div>

</body></html>