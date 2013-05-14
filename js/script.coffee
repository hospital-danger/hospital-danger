# console.log wrapper
@console ?= {}
@console.log ?= ()->

$ ()->
  $video = Popcorn('#the-video')

  $play_button = $('.button-play')
  $time_bar = $('.time-bar')
  $buffer_bar = $('.buffer_bar')
  $time_left = $('.time-left')
  duration = 0
  current_time = 0

  # shortcut to timestamp-to-seconds
  to_s = Popcorn.util.toSeconds

  to_clock = (seconds)->
    min = Math.floor seconds/60
    s = seconds % 60
    min = if min > 9 then "#{min}" else "0#{min}"
    s = if s > 9 then "#{s}" else "0#{s}"
    "#{min}:#{s}"

  cue_times = {
    "#safety": 2
    "#quality-of-care": 15
    "#infection": 20
    "#culpability": 40
    "#lawsuit": 60
    "#no-improvement": 70
  }

  # play-pause button
  $play_button.add('#the-video').on "click", ()->
    if $play_button.hasClass("paused") then $video.play() else $video.pause()
    $play_button.toggleClass("paused")

  # scrub timeline
  $('.progress').on "click", (e)->
    pos = e.offsetX / $(this).width()
    $video.currentTime( pos * duration )

  # chapter selector
  $('.chapter').on "click", (e)->
    e.preventDefault()
    target = $(this).attr 'href'

    $video.currentTime( cue_times[target] ).pause()
    $play_button.addClass('paused')

    $('.current-node').removeClass('current-node')
    $(target).addClass('current-node')

  # set css animations to cue times
  $.each cue_times, (target,value)->
    $video.cue value, ()->
      $('.current-node').removeClass('current-node');
      $(target).addClass('current-node');

  # timeline progress
  do time_line = ()->
    current_time = $video.currentTime()
    # b = $video.buffered()
    duration = $video.duration() || 0
    $time_bar.css {left: "#{current_time/duration * 100}%"}
    # $buffer_bar.css {left: "#{b/d * 100}%"}
    $time_left.text to_clock Math.floor duration - current_time
    setTimeout time_line, 200