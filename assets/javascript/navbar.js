$(document).ready(function() {
  if ($(window).width() <= 768) {
    $('.navigation__link--disabled').click(function() {
      $('svg', this).toggleClass('fa-caret-down').toggleClass('fa-caret-up');
      if ($('svg', this).hasClass('fa-caret-up')) {
        $(this).siblings('.dropdown').slideDown();
      } else {
        $(this).siblings('.dropdown').slideUp();
      }
    });
  }

  $('.navigation__button').click(function() {
    $('.navigation__background').show();
    $('.navigation').addClass('navigation--open');
    $(document.documentElement).css('overflow-y', 'hidden');

    $('.navigation__background').click(function() {
      hideMobileNavigation();
    });
  });

  function hideMobileNavigation() {
    $('.navigation__background').hide();
    $('.navigation').removeClass('navigation--open');
    $(document.documentElement).css('overflow-y', 'auto');
  }
});
