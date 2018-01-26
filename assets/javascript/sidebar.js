$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    if ($(window).width() <= 992){
      $(this).next().toggleClass('sitemap-content--open');
    }
  })
});
