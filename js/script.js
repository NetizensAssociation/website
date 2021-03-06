$(document).ready(function(){
// Adds and removes Active style from the navigation links
  $(".nav-links a").click(function(){
    $('.active-nav').removeClass('active-nav');
    $(this).addClass('active-nav')
  });
// Closes the mobile navigation  when clicking on a link and prevents the same behaviour on the desktop version
  var x = window.matchMedia("(min-width: 770px)")
  myFunction(x)
  x.addListener(myFunction)

  function myFunction(x) {
    if (x.matches) {
        null
    } else {
      $(".nav-links a").click(function(){
          $(".nav-links").slideToggle(150);
      });
    }
  }
// Toggles the visibility of the mobile navigation
  $(".mobile-nav-icon").click(function(){
    $(".nav-links").slideToggle(150);
  });
// Makes anchors scroll smoothly
  $('a[href^="#"]').on('click',function (e) {
    e.preventDefault; // don't follow the link
    var target = this.hash,
    $target = $(target);

    $('html, body').stop().animate({
     'scrollTop': $target.offset().top
   }, 350, 'linear', function () {
      window.location.hash = target;
    });
  });
// Assigns active class to nav links while scrolling
  $(window).scroll(function() {
  		var scrollDistance = $(window).scrollTop();

  		$('article').each(function(i) {
  				if ($(this).position().top-250 <= scrollDistance) {
  						$('.nav-links a.active-nav').removeClass('active-nav');
  						$('.nav-links a').eq(i).addClass('active-nav');
  				}
  		});
  }).scroll();

});

function addPolicy(url) {
  console.log('adding...', url)
  window.postMessage({
    type: 'add-campaign-policy',
    policyFileUrl: url
  }, "*")
}

function linkToExtension() {
  if(navigator.userAgent.indexOf("Firefox") != -1 ) {
    window.open('https://addons.mozilla.org/firefox/addon/picket/', '_blank')
  } else {
    window.open('https://chrome.google.com/webstore/detail/poeghfopkomankboimkibohhaomlafpd', '_blank')
  }
}
