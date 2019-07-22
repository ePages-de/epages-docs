$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    if ($(window).width() <= 992){
      if ($(this).next().hasClass('sitemap-content--open')) {
        $(this).next().removeClass('sitemap-content--open');
      } else {
        $('.sitemap-content').removeClass('sitemap-content--open');
        $(this).next().addClass('sitemap-content--open');
        $('.sitemap-headline svg').removeClass('fa-caret-up').addClass('fa-caret-down');
        $('svg', this).removeClass('fa-caret-down').addClass('fa-caret-up');
      }
    }
  })
});

function changeSiteMap(element) {
  console.log({element})
  var id = $(element).text().trim().toLowerCase();
  if($('svg', element).first().hasClass('fa-caret-down')) {
    $('svg', element).first().removeClass('fa-caret-down').addClass('fa-caret-up');
    $('#'+id).removeClass('sitemap-content-expand--close').addClass('sitemap-content-expand--open');
  } else {
    $('svg', element).first().removeClass('fa-caret-up').addClass('fa-caret-down');
    $('#'+id).removeClass('sitemap-content-expand--open').addClass('sitemap-content-expand--close');
  }
}
