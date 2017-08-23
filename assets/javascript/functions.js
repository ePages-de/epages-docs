$(document).ready(function(){

  navbarScroll();

  $(window).scroll(function (event) {
    navbarScroll();
  });

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
