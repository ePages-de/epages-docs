$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    $(this).next().toggleClass('sitemap-content--open');
  })
});
