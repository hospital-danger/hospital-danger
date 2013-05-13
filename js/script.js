/* global Popcorn:true */

// wrap console.log
if (window.console === undefined) {
  window.console = {};
  window.console.log = function() {};
}

$(document).ready(function() {
  var $video = new Popcorn('#the-video');

  $video.controls(true);

  var cue_times = {
    "#safety": 2,
    "#quality-of-care": 15,
    "#infection": 20,
    "#culpability": 40,
    "#lawsuit": 60,
    "#no-improvement": 70
  };

  $('#video-play').on("click", function(e){
    e.preventDefault();
    $video.play();
  });

  $('.chapter').on("click", function(e){
    e.preventDefault();
    var target = $(this).attr('href');
    $video.currentTime(cue_times[target]).play();
    // $video;
    $('.current-node').removeClass('current-node');
    $().addClass('current-node');
  });


  $.each(cue_times, function(key, value){
    $video.cue(value, function(){
      $('.current-node').removeClass('current-node');
      $(key).addClass('current-node');
    });
  });

});