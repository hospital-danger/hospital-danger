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
    {type: "chapter", title: "", target: "#intro", time: "00:00", hide_title: true , image:'#'}

    {type: "chapter", title: "A Safe Place?", target: "#chapter1", time: "00:20", image:'#', no_pause: true}
    {type: "element", target: "#people", time: "00:33"}
    {type: "element-next", target: "#people", time: "00:40"}
    {type: "element", target: "#causes-of-death", time: "00:42"}

    {type: "chapter", title: "No One Watching", target: "#chapter2", time: "00:52", image:'#'}
    {type: "element", target: "#show-map", time: "01:11"}

    {type: "chapter", title: "No Simple Surgery", target: "#chapter3", time: "01:33", image:'#'}
    {type: "element", target: "#bacteria", time: "01:43"}

    {type: "chapter", title: "Deny & Defend", target: "#chapter4", time: "02:10", image:'#'}
    {type: "element", target: "#slashed-circle", time: "02:22"}
    {type: "element", target: "#take-responsibility", time: "02:34"}

    {type: "chapter", title: "The Malpractice Myth" , target: "#chapter5", time: "02:44", image:'#'}
    {type: "element", target: "#lawsuits", time: "02:52"}

    {type: "chapter", title: "Result: Patient Harm" , target: "#chapter6", time: "03:10", image:'#'}
    {type: "element", target: "#dollar", time: "03:28"}

    {type: "chapter", title: "", target: "#outro", time: "03:58", hide_title: true , image:'#'}
    {type: "element", target: "#now-what", time: "03:59"}
  ]

  chapters = (cue for cue in cues when (cue.type is "chapter"))
  citations = (cue for cue in cues when (cue.type is "citation"))

  # build chapter markers
  build_chapter_markers = (chapter)->
    $el = $( "<li style='left: #{to_s(chapter.time) / 240 * 100}%;'><a href='#{chapter.target}'><img src='#{chapter.image}'><span>#{chapter.title}</span></a></li>")
    $('ul', '.chapter-list').append $el
    $video.cue to_s(chapter.time) - 1, ()->
      unless chapter.no_pause
        $video.pause()
        $(".next-chapter").addClass("show-next")

  build_chapter_markers(chapter) for chapter in chapters

  $(".next-chapter").on "click", ()->
    $video.play()

  $video.on "play", ()->
    $(".next-chapter").removeClass("show-next")
    $play_button.removeClass("paused")
    $('aside.current').removeClass('current')

  $video.on "pause", ()->
    $play_button.addClass("paused")

  toggle_play = ()->
    if $play_button.hasClass("paused") then $video.play() else $video.pause()

  # play-pause button
  $play_button.add('#the-video').on "click", toggle_play

  # scrub timeline
  # $('.progress').on "click", (e)->
  #   pos = e.offsetX / $(this).width()
  #   $video.currentTime( pos * duration )

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
  # $(document).on "keydown", (e)->
  #   space_bar = 32
  #   left_arrow = 37
  #   right_arrow = 39
  #   if e.keyCode is space_bar
  #     # todo -- toggle play
  #   else if e.keyCode is left_arrow
  #     e.preventDefault()
  #     next_chapter = Math.max 0, chapter_index - 1
  #   else if e.keyCode is right_arrow
  #     e.preventDefault()
  #     next_chapter = Math.min chapters.length - 1, chapter_index + 1

  #   if next_chapter then goto_chapter chapters[next_chapter]?.target

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

  $(".element").on "click", (e)->
    e.preventDefault()
    $video.pause()
    target = $(this).attr "href"
    if target then $(target).addClass("current")

  $(".close-aside").on "click", (e)->
    e.preventDefault()
    $(this).closest('aside').removeClass("current")
    $video.play()

  $('header.intro, .introduction').on "click", ()->
    $('#noise').remove()
    $('header').removeClass('intro')
    $('.introduction').addClass('finished')
    setTimeout ()->
      $video.play()
    , 1000
    setTimeout ()->
      $('.introduction').hide()
    , 5000

  # Nodes

  node_callbacks = {}

  #

  $(window).load ()->
    data = window.state_data

    states = $('#us-map')[0].contentDocument
    for state in states.getElementsByClassName "state"
      $(state).on "mouseenter", (e)->
        state_info = state for state in data.states when (state.state_abbreviation is @id)
        positive = ("<li>#{data.state_information_flags[key][value]}</li>" for key, value of state_info when (value is 2 and key isnt "score"))
        negative = ("<li>#{data.state_information_flags[key][value]}</li>" for key, value of state_info when (value is 1 and key isnt "score"))


        left_offset = e.offsetX
        left_offset += 50 if left_offset > 400
        top_offset = e.offsetY
        if top_offset > 300 then top_offset -= 200 #else top_offset += 100
        $("#state-info")
          .show()
          .css({top: top_offset, left: left_offset })
          .find('#state-name').text(state_info.state_title)

        $('#state-positive').html positive.join ""
        $('#state-negative').html negative.join ""

      $(state).on "mouseleave", ()->
        $('#state-info').hide()




  do ()->
    $judy = $('#judy-gaines')
    $images = $('img', $judy)
    image_count = $images.length
    # get heights of all paragraphs
    heights = [0]
    $('.sections', $judy).find('section').map (index)->
      heights.push $(this).height() + heights[index]

    $('.sections', $judy).on "scroll", ()->
      pos = $(this).scrollTop()

      index = (i for h, i in heights when ( (heights[i - 1] || 0 ) < (pos + 300) < h )) ? (image_count - 1)

      $images.removeClass('current-image').eq(index - 1).addClass('current-image')

  do ()->
    $deny = $('#deny-and-defend')
    $container = $('.aside-content', $deny)
    $papers = $('.papers', $deny)
    $events = $('.events', $deny)
    event_count = $('.event', $deny).length
    width = 6850

    pos = 0

    prefix = Modernizr.prefixed('transform')
    $.fn.parallax = (rate)->
      $this = $(this)

      do update = ()->
        window.requestAnimationFrame update
        next_css = if Modernizr.csstransforms3d
          "translate3d(#{pos * rate}px, 0, 0)"
        else
          "translateX(#{pos * rate}px)"
        $this.css(prefix, next_css)

    $('img', $papers).each (index)->
      $(this).parallax(index * 0.1)
      $(this).css({left: index * 100})

    # scroll thru papers with hover on first and last third of section
    $('.prev', $deny).hover (e)->
      $container.scrollTo({top: 0, left: 0}, 7000)
    , ()->
      $container.stop()

    $('.next', $deny).hover (e)->
      $container.scrollTo({top: 0, left: width}, 7000)
    , ()->
      $container.stop()

    papers_count = $('img', $papers).length

    $('#hospital-envelope').on "click", ()->


      # slide down response from hospital
      # something cheesy like askew paper with courier text
      $('.hospital-response').addClass("visible").on "click", ()->
        $('.visible', $deny).removeClass('visible')
        $container.scrollLeft(0)

    $container.on "scroll", ()->
      pos = $container.scrollLeft()

      index = Math.round pos / (width - 200) * event_count

      # events pop up at certain points
      $('.event', $events).removeClass('current-event').eq(index).addClass('current-event')

  # scroll decision tree
  $('a', '.decision-tree').on "click", (e)->
    e.preventDefault()
    target = $(this).attr('href')
    $('.decision-tree').scrollTo(target, 1000)

  $('#end-decision-tree').on "click", (e)->

    e.preventDefault()
    $video.play()
