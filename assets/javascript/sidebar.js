$(document).ready(function() {
  $('li.sitemap-headline').click(function() {
    if ($(window).width() <= 992){
      if ($(this).next().hasClass('sitemap-content--open')) {
        $(this).next().slideUp().removeClass('sitemap-content--open');
      } else {
        $('.sitemap-content').removeClass('sitemap-content--open');
        $(this).next().slideDown().addClass('sitemap-content--open');
        $('.sitemap-headline svg').removeClass('js-open-sitemap').addClass('fa-rotate-270');
        $('svg', this).removeClass('fa-rotate-270').addClass('js-open-sitemap');
      }
    }
  })

  $('li.sitemap-entry, li.sitemap-entry-expand').click(function() {
    $('li.sitemap-entry').removeClass('active');
    // remove font color from current active path
    $('li.sitemap-entry-expand.active').parents("ul.sitemap-content-expand").prev().removeClass('sitemap-entry-group--active');
    $('li.sitemap-entry-expand.active').removeClass('active');
    // set font color to new active path
    $(this).addClass('active')
    $(this).parents("ul.sitemap-content-expand--open").prev().addClass('sitemap-entry-group--active');
    if($(this).hasClass('js-sitemap-entry')) {
      closeSiteMap($('.js-open-sitemap').first().parent());
    }
  });

  $('li.sitemap-entry-expand--hidden').click((e) => {
    const element = e.target;
    const parentElement = $(`#${$(element).attr('parentid')}`);

    markAsActiveEntry(parentElement);
  });

  const eventMethod = window.addEventListener ? "addEventListener" : "attachEvent";
  const eventer = window[eventMethod];
  const messageEvent = eventMethod == "attachEvent" ? "onmessage" : "message";

  // Listen to message from child window
  eventer(messageEvent,function(e) {
      const key = e.message ? "message" : "data";
      const data = e[key];

      if(data === 'onbeforeunload') {
        setTimeout(()=> {
          if ($('#docs').prop('contentDocument')) {
            history.back();
          }
        } , 200);
      } else if(isUrl(data)) {
        if(data.startsWith(location.origin)) {
          const anchor = data.substring(data.indexOf('#') + 1);

          setTimeout(()=> findElement(anchor), 10);
        } else {
          const iframeUrl = $('#docs').attr('src');

          window.open(data, '_blank');
          $('#docs').attr('src', iframeUrl);
        }
      } else {
        const anchor = data.substring(data.indexOf('#') + 1);

        findElement(anchor);
      }
  },false);
});

function changeSiteMap(element) {
  if ($(element).next().is(':hidden')) { //open
    openSiteMap(element);
  } else { //close
    closeSiteMap(element);
  }
}

function openSiteMap(element) {
  nextElement = $(element).next();
  $('svg', element).first().removeClass('fa-rotate-270').addClass('js-open-sitemap');
  $(nextElement).slideDown().removeClass('sitemap-content-expand--close').addClass('sitemap-content-expand--open');
}

function closeSiteMap(element) {
  nextElement = $(element).next();
  $('svg', element).first().removeClass('js-open-sitemap').addClass('fa-rotate-270');
  $(nextElement).slideUp().removeClass('sitemap-content-expand--open').addClass('sitemap-content-expand--close');
  $(nextElement).find('.js-open-sitemap').map((i,elementSvg)=>closeSiteMap($(elementSvg).parent()));
}

function findElement(id) {
  let li = $(`li[link][id='${id}'], li[link$=${id}]`);

  if(!$(li).attr('parentid')) searchParents(li);

  $(li).click();
}

function loadEntryPointUrl(id) {
  let li = id == 'introduction' ? $(`li[link][id='${id}']`) : $(`li[link][id='${id}'], li[link$=${id}]`);

  if (li.length == 0) {
    li = $('li[link][id="introduction"]');
  }

  $('#docs').attr('src', $(li).attr('link'));
  setTimeout(function() {
    searchParents(li);
    $(li).click();
  }, 20);
}

function isUrl(str) {
  regexp =  /^(?:(?:https?|ftp):\/\/)?(?:(?!(?:10|127)(?:\.\d{1,3}){3})(?!(?:169\.254|192\.168)(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]-*)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/\S*)?$/;

  return regexp.test(str);
}

function searchParents(element) {
  if($(element).is('li')) {
    const parent = $(element).parent();

    searchParents(parent);
  } else if($(element).is('ul')) {
    const prev = $(element).prev();

    if($(prev).hasClass('js-group')) {
      searchParents(prev);
      $(prev).click();
    }
  }

}

function markAsActiveEntry(element) {
  $('li.sitemap-entry').removeClass('active');
  // remove font color from current active path
  $('li.sitemap-entry-expand.active').parents("ul.sitemap-content-expand").prev().removeClass('sitemap-entry-group--active');
  $('li.sitemap-entry-expand.active').removeClass('active');
  // set font color to new active path
  $(element).addClass('active')
  $(element).parents("ul.sitemap-content-expand--open").prev().addClass('sitemap-entry-group--active');
  if($(element).hasClass('js-sitemap-entry')) {
    closeSiteMap($('.js-open-sitemap').first().parent());
  }
}
