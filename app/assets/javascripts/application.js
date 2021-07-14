
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
}

// upLike a message
function upLike(){
 $('.uplike').on('submit', function(e){
  console.log("prevented uplike")
   e.preventDefault();
   var value, postUrl, data;
   value = 1;
   postUrl = $(this).attr('action');
   data = $(this).serialize();
   $.ajax({
     url: postUrl,
     method: 'PUT',
     data: data
   }).done(function(data) {
     $('.uplike').empty();
     $('.uplike').prepend(data);
   });
 })
};

// downLike a message
function downLike(){
 $('.downlike').on('submit', function(e){
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
    console.log("select form")
    $(this.form).submit();
  });
}
