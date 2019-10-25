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
  $('li.sitemap-entry, li.sitemap-entry-expand').click(function() {
    $('li.sitemap-entry').removeClass('active');
    $('li.sitemap-entry-expand.active').removeClass('active');
    $(this).addClass('active')
  });
});

function changeSiteMap(element) {
  if($('svg', element).first().hasClass('fa-caret-down')) { //open
    $('.fa-caret-up').each((i,elementSvg)=> { // Close other elements
      if(!$(elementSvg).parent().is($(element).parent().prev())) {
        closeSiteMap($(elementSvg).parent());
      }
    });
    $(element).addClass("sitemap-entry-group--active");
    openSiteMap(element);
  } else { //close
    closeSiteMap(element);
  }
}

function openSiteMap(element) {
  nextElement = $(element).next();
  $('svg', element).first().removeClass('fa-caret-down').addClass('fa-caret-up');
  $(nextElement).slideDown().removeClass('sitemap-content-expand--close').addClass('sitemap-content-expand--open');
}

function closeSiteMap(element) {
  $(element).removeClass("sitemap-entry-group--active");
  nextElement = $(element).next();
  $('svg', element).first().removeClass('fa-caret-up').addClass('fa-caret-down');
  $(nextElement).slideUp().removeClass('sitemap-content-expand--open').addClass('sitemap-content-expand--close');
  $(nextElement).find('.fa-caret-up').map((i,elementSvg)=>closeSiteMap($(elementSvg).parent()));
}
