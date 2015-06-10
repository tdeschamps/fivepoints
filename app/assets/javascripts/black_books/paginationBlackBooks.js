jQuery(function() {
  $('.see-more').on('click', function() {
      var more_posts_url;
      more_posts_url = $(this).parent().parent().find('.pagination > a.next_page').attr('href');
      if (more_posts_url) {
        $.getScript(more_posts_url);

      }
      return;
  });
});