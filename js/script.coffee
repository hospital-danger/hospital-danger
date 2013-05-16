# console.log wrapper
@console ?= {}
@console.log ?= ()->

# shortcut to timestamp-to-seconds
to_s = Popcorn.util.toSeconds

to_clock = (seconds)->
  min = Math.floor seconds/60
  s = seconds % 60
  min = if min > 9 then "#{min}" else "0#{min}"
  s = if s > 9 then "#{s}" else "0#{s}"
  "#{min}:#{s}"

$ ()->
  $video = Popcorn('#the-video')

  $play_button = $('.playpause')
  $time_bar = $('.time-bar')
  $buffer_bar = $('.buffer_bar')
  $time_left = $('.time-left')
  $time_elapsed = $('.time-elapsed')
  duration = 0
  current_time = 0
  chapter_index = 0

  cues = [
    {type: "chapter", title: "Intro", target: "#intro", time: "00:00", hide_title: true}

    {type: "chapter", title: "A Safe Place", target: "#safety", time: "00:20"}
    {type: "element", target: "#people", time: "00:33"}
    {type: "element-next", target: "#people", time: "00:40"}
    {type: "element", target: "#causes-of-death", time: "00:42"}
    {type: "chapter_end", time: "00:47"}

    {type: "chapter", title: "Quality of Care", target: "#quality-of-care", time: "00:52"}
    {type: "element", target: "#states", time: "01:11"}
    # 121 only 3
    {type: "chapter_end", time: "01:29"}

    {type: "chapter", title: "Deceptively Simple", target: "#infection", time: "01:33"}
    {type: "element", target: "#bacteria", time: "01:43"}
    {type: "chapter_end", time: "02:08"}

    {type: "chapter", title: "Deny & Defend", target: "#culpability", time: "02:10"}
    {type: "element", target: "#deny-and-defend", time: "02:22"}
    {type: "element", target: "#take-responsibility", time: "02:34"}
    {type: "chapter_end", time: "02:41"}

    {type: "chapter", title: "Malpractice in Practice" , target: "#malpractice-in-practice", time: "02:44"}
    {type: "element", target: "#lawsuits", time: "02:52"}
    {type: "chapter_end", time:"03:06"}

    {type: "chapter", title: "Getting Better?" , target: "#no-improvement", time: "03:10"}
    {type: "element", target: "#pinch-pennies", time: "03:28"}
    {type: "element", target: "#wash-hands", time: "03:48"}

    {type: "chapter", title: "End", target: "#end", time: "03:58", hide_title: true}
  ]

  chapters = (cue for cue in cues when (cue.type is "chapter"))
  citations = (cue for cue in cues when (cue.type is "citation"))

  # build chapter markers
  $('ul', '.chapter-list').append( "<li><a href='#{cue.target}'>#{cue.title}</a></li>") for cue in chapters

  $video.on "play", ()->
    $play_button.removeClass("paused")

  $video.on "pause", ()->
    $play_button.addClass("paused")

  toggle_play = ()->
    if $play_button.hasClass("paused") then $video.play() else $video.pause()

  # play-pause button
  $play_button.add('#the-video').on "click", toggle_play

  # scrub timeline
  $('.progress').on "click", (e)->
    pos = e.offsetX / $(this).width()
    $video.currentTime( pos * duration )

  goto_chapter = (target)->
    [chapter_index, cue_time] = [index, to_s(cue.time)] for cue, index in cues when (cue.target is target)
    $video.currentTime( cue_time ).play() if cue_time?
    $('.current-chapter').removeClass "current-chapter"
    $("[href='#{target}']").addClass "current-chapter"

  # chapter selector
  $('a', '.chapter-list').on "click", (e)->
    e.preventDefault()
    goto_chapter $(this).attr 'href'

  # arrow keys to advance between chapters
  $(document).on "keydown", (e)->
    space_bar = 32
    left_arrow = 37
    right_arrow = 39
    if e.keyCode is space_bar
      # todo -- toggle play
    else if e.keyCode is left_arrow
      e.preventDefault()
      next_chapter = Math.max 0, chapter_index - 1
    else if e.keyCode is right_arrow
      e.preventDefault()
      next_chapter = Math.min chapters.length - 1, chapter_index + 1

    if next_chapter then goto_chapter chapters[next_chapter]?.target

  # timeline progress
  $video.on "timeupdate", ()->
    current_time = $video.currentTime()
    duration = $video.duration() || 0
    $time_bar.css {left: "#{current_time/duration * 100}%"}
    $time_elapsed.text to_clock Math.floor current_time
    $time_left.text to_clock Math.floor duration - current_time

  # set css animations to cue times
  $.each cues, (i, cue_item)->
    $video.cue to_s(cue_item.time), ()->
      switch cue_item.type
        when "citation"
          $('.citations').html "<a href='#{cue_item.target}' target='_blank'>#{cue_item.title}</a>"
        when "chapter"
          $('.current').removeClass("current")
          $('.current-2').removeClass("current-2")
          $('.chapter-title').show().text( cue_item.title).delay(3000).fadeOut(2000) unless cue_item.hide_title
          $('.current-chapter').removeClass "current-chapter"
          $("[href='#{cue_item.target}']").addClass "current-chapter"
        when "element"
          $(cue_item.target).addClass('current')
          node_callbacks[cue_item.callback]?()
        when "element-next"
          $(cue_item.target).addClass('current-2')
          node_callbacks[cue_item.callback]?()
        when "chapter_end"
          # pause between chapters
          $video.pause()

  $(".element").on "click", (e)->
    e.preventDefault()
    $video.pause()
    target = $(this).attr "href"
    if target then $(target).addClass("current")


  $(".close-aside").on "click", (e)->
    e.preventDefault()
    $(this).closest('aside').removeClass("current")
    $video.play()

  $('header.intro').on "click", ()->
    $(this).removeClass('intro')
    $('.introduction').addClass('finished')
    setTimeout ()->
      $video.play()
    , 1000
    setTimeout ()->
      $('.introduction').hide()
    , 5000

  # Nodes

  node_callbacks = {}

  do ()->
    $judy = $('#judy-gaines')
    $images = $('.image-container', $judy)
    height = $('.text-inner', $judy).height() - $judy.height()
    $('.text-container', $judy).on "scroll", ()->
      pos = $(this).scrollTop()
      index = Math.floor( pos / height * 4)
      $('img', $images).removeClass('current-image').eq(index).addClass('current-image')

  do ()->
    # scroll thru papers with hover on first and last third of section
    # papers scroll at diff'rent speeds
    # relevant block quotes pop up at certain points
    # when the user scrolls to end of section, fade out papers
    # slide down response from hospital
    # something cheesy like askew paper with courier text

  # scroll decision tree
  $('a', '.decision-tree').on "click", (e)->
    e.preventDefault()
    target = $(this).attr('href')
    $('.decision-tree').scrollTo(target, 1000)

  $('#end-decision-tree').on "click", (e)->

    e.preventDefault()
    $video.play()

