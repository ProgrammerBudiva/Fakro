<div class="">
  <div class="row">
      <div id="content" class=""><?php echo $content_top; ?>
          <h1><?php echo $heading_title; ?></h1>
          <?php echo $text_message; ?>
          <div class="buttons">
        <div class=""><a href="/" class="btn btn-primary" id="success-popup-close-button"><?php echo $button_continue; ?></a></div>
      </div>
          <script>
              $(document).on('click' ,function () {
                  if ($(event.target).closest("#success-popup-close-button").length) return;
                  $(location).attr('href', '/')

              });
          </script>
</div>
