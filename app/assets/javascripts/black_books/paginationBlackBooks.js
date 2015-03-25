jQuery(function() {
  $('.see-more').on('click', function() {
      var more_posts_url;
      more_posts_url = $(this).parent().parent().find('.pagination > a.next_page').attr('href');
      console.log(more_posts_url);
      if (more_posts_url) {
        $('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />');
        $.getScript(more_posts_url);

      }
      return;
  });
});