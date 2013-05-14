# console.log wrapper
@console ?= {}
@console.log ?= ()->

$ ()->
  $video = Popcorn('#the-video')

  $video.controls true

  cue_times = {
    "#safety": 2
    "#quality-of-care": 15
    "#infection": 20
    "#culpability": 40
    "#lawsuit": 60
    "#no-improvement": 70
  }

  # chapter selector
  $('.chapter').on "click", (e)->
    e.preventDefault()
    target = $(this).attr 'href'
    $video.currentTime( cue_times[target] ).pause()
    $('.current-node').removeClass('current-node')
    $(target).addClass('current-node')

  $.each cue_times, (target,value)->
    $video.cue value, ()->
      $('.current-node').removeClass('current-node');
      $(target).addClass('current-node');