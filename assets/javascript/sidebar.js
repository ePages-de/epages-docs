$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    if ($(window).width() <= 992){
      if ($(this).next().hasClass('sitemap-content--open')) {
        $(this).next().slideUp().removeClass('sitemap-content--open');
      } else {
        $('.sitemap-content').removeClass('sitemap-content--open');
        $(this).next().slideDown().addClass('sitemap-content--open');
        $('.sitemap-headline svg').removeClass('fa-caret-up').addClass('fa-caret-down');
        $('svg', this).removeClass('fa-caret-down').addClass('fa-caret-up');
      }
    }
  })
  $('li.sitemap-entry-expand').click(function() {
    $('li.sitemap-entry-expand.active').removeClass('active');
    $(this).addClass('active');
  })
});

function changeSiteMap(element) {
  var id = $(element).text().trim().toLowerCase();
  if($('svg', element).first().hasClass('fa-caret-down')) {
    $('svg', element).first().removeClass('fa-caret-down').addClass('fa-caret-up');
    $('#'+id).slideDown().removeClass('sitemap-content-expand--close').addClass('sitemap-content-expand--open');
  } else {
    $('svg', element).first().removeClass('fa-caret-up').addClass('fa-caret-down');
    $('#'+id).slideUp().removeClass('sitemap-content-expand--open').addClass('sitemap-content-expand--close');
  }
}
