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
  $progess = $('.progress')
  duration = 0
  current_time = 0
  chapter_index = 0

  cues = [
    {type: "chapter", title: "A Safe Place?", target: "#chapter1", time: "00:20", image: 'img/chapter-1.png', no_pause: true}
    {type: "citation", title: "OIG: Adverse Events in Hospitals", target: "https://www.documentcloud.org/documents/436100-oig-adverse-events-in-hospitals.html#document/p3/a74093", time: "00:33"}
    {type: "citation", title: "CDC: Estimating Healthcare-Associated Infections...", target: "https://www.documentcloud.org/documents/701516-cdc-hai-infections-deaths.html#document/p1/a103231", time: "00:35"}
    {type: "citation", title: "IOM: To Err Is Human", target: "https://www.documentcloud.org/documents/436100-oig-adverse-events-in-hospitals.html#document/p3/a74093", time: "00:37"}
    {type: "element", target: "#people", time: "00:38"}
    {type: "citation", title: "CDC: Leading Causes of Death", target: "http://www.cdc.gov/nchs/fastats/lcod.htm", time: "00:43"}

    {type: "chapter", title: "Unchecked Errors", target: "#chapter2", time: "00:47", image: 'img/chapter-2.png'}
    {type: "citation", title: "IOM: To Err Is Human", target: "https://www.documentcloud.org/documents/286678-to-err-is-human-download.html#document/p112/a74097", time: "00:52"}
    {type: "citation", title: "Makary, M.: Testimony Before Committee on Oversight and Government Reform...", target: "https://www.documentcloud.org/documents/693471-house-transparency-hearing-makary-testimony.html#document/p2/a103232", time: "01:12"}
    {type: "element", target: "#us-map", time: "01:11"}
    {type: "element", target: "#show-map", time: "01:12"}

    {type: "chapter", title: "No Simple Surgery", target: "#chapter3", time: "01:23", image: 'img/chapter-3.png'}
    {type: "citation", title: "CDC: Estimating Healthcare-Associated Infections..", target: "https://www.documentcloud.org/documents/701516-cdc-hai-infections-deaths.html#document/p1/a103231", time: "01:34"}
    {type: "element", target: "#bacteria", time: "01:54"}

    {type: "chapter", title: "Deny & Defend", target: "#chapter4", time: "01:55", image: 'img/chapter-4.png'}
    {type: "citation", title: "Boothman, R.: Nurturing a culture of patient safety...", target: "https://www.documentcloud.org/documents/701526-boothman-ache-frontiers.html#document/p2/a103234", time: "02:05"}
    {type: "element", target: "#slashed-circle", time: "02:23"}

    {type: "chapter", title: "The Malpractice Myth" , target: "#chapter5", time: "02:26", image: 'img/chapter-5.png'}
    {type: "citation", title: "Shepherd, J.: Uncovering the Silent Victims..", target: "https://www.documentcloud.org/documents/698248-emory-med-mal-study.html#document/p36/a103236", time: "02:31"}
    {type: "element", target: "#lawsuits", time: "02:38"}
    {type: "citation", title: "Shepherd, J.: Uncovering the Silent Victims..", target: "https://www.documentcloud.org/documents/698248-emory-med-mal-study.html#document/p36/a103236", time: "02:38"}

    {type: "chapter", title: "Result: Patient Harm" , target: "#chapter6", time: "02:47", image: 'img/chapter-6.png'}
    {type: "citation", title: "AIG: Patient Safety; Hospital Risk", target: "https://www.documentcloud.org/documents/690849-aig-patient-safety-hospital-risk-white-paper.html#document/p4/a99951", time: "03:03"}
    {type: "citation", title: "AHRQ: Hospital survey on patient safety culture...", target: "https://www.documentcloud.org/documents/215362-ahrq-hospital-safety-culture-survey-2011-part-one.html#document/p41/a26651", time: "03:05"}
    {type: "citation", title: "AHRQ: Hospital Nurse Staffing and Quality of Care", target: "https://www.documentcloud.org/documents/700433-nurse-staffing-study-and-infections.html#document/p1/a102854", time: "03:08"}
    {type: "citation", title: "American Nurse Today: Break the bullying cycle", target: "http://www.americannursetoday.com/article.aspx?id=8648", time: "03:13"}
    {type: "citation", title: "AIG: Patient Safety; Hospital Risk", target: "https://www.documentcloud.org/documents/690849-aig-patient-safety-hospital-risk-white-paper.html", time: "03:15"}
    {type: "citation", title: "McGuckin, M.: Hand Hygiene Compliance in the United States...", target: "https://www.documentcloud.org/documents/699985-hand-hygiene-compliance-rates-in-the-u-am-j-med.html#document/p1/a102851", time: "03:20"}
    {type: "element", target: "#hand", time: "03:24"}

    {type: "chapter", title: "" , target: "#outro", time: "03:26", image: "#", no_marker: true}
    {type: "citation", title: "AHRQ: Hospital survey on patient safety culture...", target: "https://www.documentcloud.org/documents/215362-ahrq-hospital-safety-culture-survey-2011-part-one.html#document/p8/a103237", time: "03:27"}

    {type: "element", target: "#now-what", time: "03:33"}
  ]

  chapters = (cue for cue in cues when (cue.type is "chapter"))
  citations = (cue for cue in cues when (cue.type is "citation"))

  # build chapter markers
  build_chapter_markers = (chapter)->
    $el = $( "<li style='left: #{to_s(chapter.time) / 240 * 100}%;'><a href='#{chapter.target}'><img src='#{chapter.image}'><span>#{chapter.title}</span></a></li>")
    $('ul', '.chapter-list').append $el unless chapter.no_marker
    $video.cue to_s(chapter.time) - 1, ()->
      unless chapter.no_pause
        $video.pause()
        $(".next-chapter").addClass("show-next")
        $(".instruction").addClass("show-instruction")

  build_chapter_markers(chapter) for chapter in chapters

  $(".next-chapter").on "click", ()->
    $video.play()

  $video.on "play", ()->
    $(".next-chapter").removeClass("show-next")
    $(".instruction").removeClass("show-instruction")
    $play_button.removeClass("paused")
    $('aside.current').removeClass('current')
    $('#now-what').removeClass('current')

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
    $progess.css {left: "#{current_time/duration * 100}%"}

  # set css animations to cue times
  $.each cues, (i, cue_item)->
    $video.cue to_s(cue_item.time), ()->
      switch cue_item.type
        when "citation"
          $('.citations')
            .html( "<a href='#{cue_item.target}' target='_blank'>#{cue_item.title}</a>")
            .stop().show().delay(2000).fadeOut(1000)
        when "chapter"
          $('.current').removeClass("current")
          $('.current-2').removeClass("current-2")
          $('.chapter-title').show().text( cue_item.title).delay(3000).fadeOut(2000) unless cue_item.hide_title
          $('.current-chapter').removeClass "current-chapter"
          $("[href='#{cue_item.target}']").addClass "current-chapter"
        when "element"
          $(cue_item.target).addClass('current')

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
    music = $('#the-music')[0]
    music.play()

    setTimeout ()->
      $video.play()
    , 1000
    setTimeout ()->
      $('.introduction').remove()
      $('header p').remove()
      $('header .start-button').remove()
    , 5000

  # Nodes

  $(window).load ()->
    data = window.state_data

    states = $('#us-map')[0].contentDocument
    for state in states.getElementsByTagName "path"
      $(state).on "mouseenter", (e)->
        if $('#us-map').hasClass('expanded')
          state_info = state for state in data.states when ("#{state.state_abbreviation}_1_" is @id)
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

      $(state).on "click", ()->
        $('.instruction').removeClass('show-instructionzx')
        if $('#us-map').hasClass('expanded') then $video.play() else $video.pause()
        $video.pause()
        $('#us-map').toggleClass("expanded")


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
    $('.explanation').html $(this).closest('.decision').data("failure-explanation")
    $('.decision-tree-container').scrollTo(target, 1000)

  # start decision tree at the right coords
  $('.decision-tree-container').scrollTo('#decision-1', 0)


  $('#go-to-credits').on "click", ()->
    $('#credits').show()

  $('#close-credits','#credits').on "click", (e)->
    e.preventDefault()
    $('#credits').hide()