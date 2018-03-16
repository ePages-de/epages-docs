$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    if ($(window).width() <= 992){
      $('.sitemap-content').removeClass('sitemap-content--open');
      $(this).next().addClass('sitemap-content--open');
      $('.sitemap-headline svg').removeClass('fa-caret-up').addClass('fa-caret-down');
      $('svg', this).removeClass('fa-caret-down').addClass('fa-caret-up');
    }
  })
});
