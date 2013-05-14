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
  chapter_index = 0

  # shortcut to timestamp-to-seconds
  to_s = Popcorn.util.toSeconds

  to_clock = (seconds)->
    min = Math.floor seconds/60
    s = seconds % 60
    min = if min > 9 then "#{min}" else "0#{min}"
    s = if s > 9 then "#{s}" else "0#{s}"
    "#{min}:#{s}"

  cues = [
    {type:"chapter", title: "A Safe Place", target: "#safety", time: "00:10"}
    {type:"chapter", title: "Quality of Care", target: "#quality-of-care", time: "00:20"}
    {type:"chapter", title: "Deceptively Simple" , target: "#infection", time: "00:30"}
    {type:"chapter", title: "Deny & Defend", target: "#culpability", time: "00:40"}
    {type:"chapter", title: "Malpractice in Practice" , target: "#lawsuit", time: "00:50"}
    {type:"chapter", title: "Is It Getting Better?" , target: "#no-improvement", time: "01:00"}
  ]

  chapters = (cue for cue in cues when (cue.type is "chapter"))
  citations = (cue for cue in cues when (cue.type is "citation"))

  # build chapter markers
  $('ul', '.chapter-list').append( "<li><a href='#{cue.target}'>#{cue.title}</a></li>") for cue in chapters

  # play-pause button
  $play_button.add('#the-video').on "click", ()->
    if $play_button.hasClass("paused") then $video.play() else $video.pause()
    $play_button.toggleClass("paused")

  # scrub timeline
  $('.progress').on "click", (e)->
    pos = e.offsetX / $(this).width()
    $video.currentTime( pos * duration )

  goto_chapter = (target)->
    [chapter_index, cue_time] = [index, to_s(cue.time)] for cue, index in cues when (cue.target is target)
    $video.currentTime( cue_time ).pause() if cue_time?
    $play_button.addClass('paused')

  # chapter selector
  $('a', '.chapter-list').on "click", (e)->
    e.preventDefault()
    goto_chapter $(this).attr 'href'

  # arrow keys to advance between chapters
  $(document).on "keydown", (e)->
    left_arrow = 37
    right_arrow = 39
    if e.keyCode is left_arrow
      e.preventDefault()
      next_chapter = Math.max 0, chapter_index - 1
    else if e.keyCode is right_arrow
      e.preventDefault()
      next_chapter = Math.min chapters.length - 1, chapter_index + 1

    goto_chapter chapters[next_chapter]?.target

  # set css animations to cue times
  $.each cues, (i, cue_item)->
    $video.cue to_s(cue_item.time), ()->
      $('.current', ".element").removeClass('current');
      $(cue_item.target).addClass('current');

  # timeline progress
  do time_line = ()->
    current_time = $video.currentTime()
    duration = $video.duration() || 0
    $time_bar.css {left: "#{current_time/duration * 100}%"}
    $time_left.text to_clock Math.floor duration - current_time
    setTimeout time_line, 200