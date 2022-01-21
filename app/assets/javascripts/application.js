
// ...
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require popper
//= require jquery.easing.1.3
//= require bootstrap
//= require owl.carousel.min
//= require jquery.magnific-popup.min
//= require hoverIntent
//= require supersubs
//= require respond.min
//= require modernizr-2.6.2.min
//= require jquery.parallax-scroll.min
//= require superfish
//= require easyResponsiveTabs
//= require fastclick
//= require custom
//= require main
window.addEventListener("load", () => {
  eventListeners();
});

function eventListeners(){
  // upLike();
  // downLike();
  submit_categories();
  playMessageAudio();
  getCookie('rct');
  selectActiveFilter();
}

function getCookie(name) {
  match = document.cookie.match(new RegExp(name + '=([^;]+)'));
  if (match) return match[1];
}

// upLike a message
function upLike(){
 $('#uplike').on('click', function(e){
   e.preventDefault();
   var rct = getCookie('rct');
   var value, postUrl, data;
   value = 1;
   postUrl = $(this).parent().parent().attr('action');
   data = $(this).parent().serialize();
   console.log(data);
   $.ajax({
     url: postUrl,
     method: 'POST',
     headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content'), // Optional
      'Content-Type': 'application/json'
      },
     data: JSON.stringify({ "up": value }),
   }).done(function(data) {
     $('.uplike').empty();
     $('.uplike').prepend(data);
   });
 })
};

// downLike a message
function downLike(){
 $('#downlike').on('submit', function(e){
   console.log("prevented downlike")
   e.preventDefault();
   $(this).siblings('.del').toggle();
   var tags, postUrl, data;
   tags = $(this);
   postUrl = $(this).attr('action');
   data = $(this).children(':first').serialize();
   $.ajax({
     url: postUrl,
     method: 'PUT',
     data: data
   }).done(function(data) {
     tags.toggle();
     $('.tag-value').empty();
     $('.tag-value').prepend(data);
   });
 })
};

function submit_categories(){
  $('select').change(function(){
    $('#category').submit();
  });
}

function playMessageAudio(){
  $("#player").click(function(){
    if ($(this).children('audio')[0].paused){
      $(this).children('audio')[0].play();
      $("#player").addClass("playing");
      $("#player-control").removeClass("ti-control-play");
      $("#player-control").addClass("ti-control-pause");
    } else {
      $(this).children('audio')[0].pause()
      $("#player").removeClass("playing");
      $("#player-control").addClass("ti-control-play");
      $("#player-control").removeClass("ti-control-pause");
    }
  });
}

function selectActiveFilter(){
  var queryString = window.location.href.slice(window.location.href.indexOf('='));
  queryParam = queryString.replace(/=/g, '');
  queryParam = queryParam.replace(/\+/g, ' ');
  $("#category-form > option[value='" + queryParam + "']").prop('selected', true)
};
