$(document).ready(function() {
  fadeArrow();

  $('.arrow-up').click(function() {
    $('html, body').animate({ scrollTop: 0 }, 800, 'swing');
  });

  $(window).scroll(function() {
    fadeArrow();
  });

  function fadeArrow() {
    if ($(this).scrollTop()>500) {
      $('.arrow-up').fadeIn();
    } else {
      $('.arrow-up').fadeOut();
    }
  }
});
