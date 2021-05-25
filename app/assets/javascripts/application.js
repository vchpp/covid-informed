
// ...
//= require activestorage
//= require trix
//= require trix-core
//= require actiontext
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

$(document).on('turbolinks:load', function(){
  eventListeners();
});

function eventListeners(){
  upVote();
  downVote();
}

// upvote a message
function upVote(){
 $('.tags').on('submit', function(e){
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

// downvote a message
function downVote(){
 $('.tags').on('submit', function(e){
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
