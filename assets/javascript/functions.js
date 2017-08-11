$(document).ready(function(){

  var path = window.location.pathname,
      regex = /\/apps\/(.+)/;

  navbarScroll();

  $(window).scroll(function (event) {
    navbarScroll();
  });

  if ( regex.test(path) ) {
    var vh = $('header.jumbotron').outerHeight() - $('nav').outerHeight();
    // Animation
    $('html,body').animate({
        scrollTop: vh
      }, 900);
    // $(document).scrollTop(vh);
  }

  function navbarScroll() {
    if ( $(document).scrollTop() >= 50 ) {
      $('nav').addClass('white');
      $('.navbar-brand').addClass('gray');
    } else if ( $(document).scrollTop() < 50 ) {
      $('nav').removeClass('white');
      $('.navbar-brand').removeClass('gray');
    }
  }

});
