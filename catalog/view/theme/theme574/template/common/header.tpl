<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>

	<!-- Google Tag Manager -->
	<script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
        new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
                j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
                'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
                })(window,document,'script','dataLayer','GTM-KVXR8BM');</script>
	<!-- End Google Tag Manager →


	<!-- Yandex.Metrika counter -->
	<script type="text/javascript" >
        (function (d, w, c) {
            (w[c] = w[c] || []).push(function() {
                try {
                    w.yaCounter48329126 = new Ya.Metrika({
                        id:48329126,
                        clickmap:true,
                        trackLinks:true,
                        accurateTrackBounce:true,
                        webvisor:true
                    });
                } catch(e) { }
            });

            var n = d.getElementsByTagName("script")[0],
                s = d.createElement("script"),
                f = function () { n.parentNode.insertBefore(s, n); };
            s.type = "text/javascript";
            s.async = true;
            s.src = "https://mc.yandex.ru/metrika/watch.js";

            if (w.opera == "[object Opera]") {
                d.addEventListener("DOMContentLoaded", f, false);
            } else { f(); }
        })(document, window, "yandex_metrika_callbacks");
	</script>
	<noscript><div><img src="https://mc.yandex.ru/watch/48329126" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
	<!-- /Yandex.Metrika counter -->

<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="google-site-verification" content="p4FJcgvPM9vgsTqOp31dMTEu1jd99xVAW5ssiCZNl_M" />
<meta name="yandex-verification" content="92c0c44604a8e857" />
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<link href='//fonts.googleapis.com/css?family=Ubuntu:400,300,700' rel='stylesheet' type='text/css'>

<link rel="stylesheet"  href="catalog/view/theme/<?php echo $theme_path; ?>/js/fancybox/jquery.fancybox.css" media="screen" />
<link href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css" rel="stylesheet">
<link href="catalog/view/theme/<?php echo $theme_path; ?>/stylesheet/photoswipe.css" rel="stylesheet">
<link href="catalog/view/theme/<?php echo $theme_path; ?>/stylesheet/magnificent.css" rel="stylesheet">
<link href="catalog/view/theme/<?php echo $theme_path; ?>/stylesheet/material-design.css" rel="stylesheet">
<link href="catalog/view/theme/<?php echo $theme_path; ?>/js/jquery.bxslider/jquery.bxslider.css" rel="stylesheet">
<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<link href="catalog/view/theme/<?php echo $theme_path; ?>/stylesheet/stylesheet.css" rel="stylesheet">

<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/common.js" type="text/javascript"></script>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/fancybox/jquery.fancybox.js"></script>
<!--Green Sock-->
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/greensock/jquery.gsap.min.js" type="text/javascript"></script>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/greensock/TimelineMax.min.js" type="text/javascript"></script>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/greensock/TweenMax.min.js" type="text/javascript"></script>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/greensock/jquery.scrollmagic.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>



<!--custom script-->
<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<script src="catalog/view/theme/<?php echo $theme_path; ?>/js/device.min.js" type="text/javascript"></script>
<!--[if lt IE 9]><div style='clear:both;height:59px;padding:0 15px 0 15px;position:relative;z-index:10000;text-align:center;'><a href="http://www.microsoft.com/windows/internet-explorer/default.aspx?ocid=ie6_countdown_bannercode"><img src="http://storage.ie6countdown.com/assets/100/images/banners/warning_bar_0000_us.jpg" border="0" height="42" width="820" alt="You are using an outdated browser. For a faster, safer browsing experience, upgrade for free today." /></a></div><![endif]--> 
<?php echo $google_analytics; ?>
</head>
<body class="<?php echo $class; ?>">

<!-- Google Tag Manager (noscript) -->
<noscript><iframe src="https://www.googletagmanager.com/ns.html?id=GTM-KVXR8BM"
				  height="0" width="0" style="display:none;visibility:hidden"></iframe></noscript>
<!-- End Google Tag Manager (noscript) -->

<p id="gl_path" class="hidden"><?php echo $theme_path;?></p>
<!-- swipe menu -->
<div class="swipe">
    <div class="swipe-menu">

		<ul class="foot foot-1">
			<?php if ($categories) { ?>
			<div class="container">
				<div id="menu-gadget" class="menu-gadget">

					<?php if ($categories_tm) {  echo $categories_tm; } ?>
				</div>
			</div>

			<script type="text/javascript">
                jQuery(window).load(function () {
                    if ($('body').width() > 767) {

                    }});
			</script>

			<?php } ?>
		</ul>
		<!--<ul class="foot">
			<li><a href="http://fakro1.dev/delivery">Доставка и оплата</a></li>
			<li><a href="http://fakro1.dev/contact-us">Контакты</a></li>
		</ul>
        <ul class="foot foot-1">
            <li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
        </ul>

        <ul class="foot foot-2">
            <li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
            <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
            <li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
        </ul>
        <ul class="foot foot-3">
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $newsletter; ?>"><?php echo $text_newsletter; ?></a></li>
        </ul>-->
    </div>
</div>
<div id="page">
<div class="shadow"></div>
<div class="toprow-1">
	<a class="swipe-control" href="#"><i class="fa fa-align-justify"></i></a>
</div>

<header class="header">
	<div class="container">
		<div id="logo" class="logo">
			<?php if ($logo) { ?>
			<a href="/"><img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>" class="img-responsive" /></a>
			<?php } else { ?>
			<h1><a href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
			<?php } ?>
		</div>
		
		<div class="pull-right">
		<?php if(1 == 0){ ?>
		<div class="button-setting toggle-wrap">
			<span class="toggle material-design-settings49"  type="button" ></span>
			<div class="toggle_cont pull-right">
				<?php echo $currency; ?>
				<?php echo $language; ?>
			</div>
		</div>
		<?php } ?>
		<span id="search-2">
			<i class="material-design-search100" style="color: #3aa935;"></i>
		</span>
		<?php echo $cart; ?>

		<div class=" box-cart compare toggle-wrap">
			<a href="/compare-products">
				<i class="material-design-shuffle24"></i>
				<span id="compare-total-2"><?php echo $compare_2; ?></span>
			</a>
		</div>


		<div class="call_me toggle-wrap" >
		<div data-toggle="collapse" data-target="#demo" class="call_me_div" >
			<span>Перезвоните мне</span>

		</div>
			<div id="demo" class="phone_content collapse">
				<input placeholder="+38 (___) ___-__-__" type="text" name="callback_phone"  class="phone-input">
				<div id="send_phone">Отправить</div>
			</div>
		</div>

			<div class=" toggle-wrap search phone-number">
			<span style="font-size: 23px; letter-spacing: -1px; font-weight: 400;">
				<i class="material-design-phone370" style="color:#3aa935;"></i>
				(800) 300 506
			</span>
			</div>
		<?php echo $search; ?>
		<!--<span id="search-2">
			<i class="material-design-search100" style="color: #3aa935;"></i>
		</span>-->
		</div>
		
	</div>


	<?php if ($categories) { ?>
	<!--<div class="container">
		<div id="menu-gadget" class="menu-gadget">
			<div id="menu-icon" class="menu-icon"><?php echo $text_category; ?></div>
			<?php if ($categories_tm) {  echo $categories_tm; } ?>
		</div>
	</div>
	
	<script type="text/javascript">
		jQuery(window).load(function () {
		if ($('body').width() > 767) {
			$('#tm_menu').TMStickUp({})
		
		}});
	</script>-->

	<div id="tm_menu" class="nav__primary">
		<div class="test">
			<div class="container">
				<?php if ($categories_tm) {  echo $categories_tm; } ?>
				<div class="clear"></div>
			</div>
		</div>
	</div>
	<?php } ?>

</header>