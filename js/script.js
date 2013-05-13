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
    "safety": "0:02",
    "quality-of-care": "0:05",
    "infection": "0:20",
    "culpability": "0:40",
    "lawsuit": "1:00",
    "no-improvement": "1:10"
  };

  $('#video-play').on("click", function(e){
    e.preventDefault();
    $video.play();
  });

  $.each(cue_times, function(key, value){
    $video.cue(value, function(){
      $('.current-node').removeClass('current-node');
      $('#' + key).addClass('current-node');
    });
  });

});