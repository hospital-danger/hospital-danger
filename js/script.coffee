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

  $play_button = $('.button-play')
  $time_bar = $('.time-bar')
  $buffer_bar = $('.buffer_bar')
  $time_left = $('.time-left')
  $time_elapsed = $('.time-elapsed')
  duration = 0
  current_time = 0
  chapter_index = 0

  cues = [
    {type:"chapter", title: "A Safe Place", target: "#safety", time: "00:19"}


    {type:"chapter", title: "Quality of Care", target: "#quality-of-care", time: "00:42"}



    {type:"chapter", title: "Deceptively Simple" , target: "#infection", time: "01:09"}



    {type:"chapter", title: "Deny & Defend", target: "#culpability", time: "01:34"}



    {type:"chapter", title: "Malpractice in Practice" , target: "#lawsuit", time: "01:58"}



    {type:"chapter", title: "Is It Getting Better?" , target: "#no-improvement", time: "02:17"}
  ]

  chapters = (cue for cue in cues when (cue.type is "chapter"))
  citations = (cue for cue in cues when (cue.type is "citation"))

  # build chapter markers
  $('ul', '.chapter-list').append( "<li><a href='#{cue.target}'>#{cue.title}</a></li>") for cue in chapters

  toggle_play = ()->

    if $play_button.hasClass("paused") then $video.play() else $video.pause()
    $play_button.toggleClass("paused")

  # play-pause button
  $play_button.add('#the-video').on "click", toggle_play

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

    goto_chapter chapters[next_chapter]?.target

  # set css animations to cue times
  $.each cues, (i, cue_item)->
    $video.cue to_s(cue_item.time), ()->
      # $('.current', ".element").removeClass('current');
      # $(cue_item.target).addClass('current');
      switch cue_item.type
        when "citation"
          $('.citations').html "<a href='#{cue_item.target}' target='_blank'>#{cue_item.title}</a>"
        when "chapter_end"
          # pause between chapters, except between intro and first chapter
          unless cue_item.target is "#safety"
            $video.pause()
            $play_button.addClass('paused')

  # bacteria track cursor
  # $(document).on "mousemove", (e)->
  #   console.log  e
  #   # console.log /e.clientX, e.clientY

  # animate bacteria
  do ()->
    $bacteria = $("#bacteria")
    $parent = $bacteria.parent()
    $bacteria.attr('width', $parent.width() ).attr('height', $parent.height())
    bacteria_canvas = $bacteria[0]
    ctx = bacteria_canvas.getContext "2d"
    width = $bacteria.width() / 4
    height = $bacteria.height() / 4
    # initialize data
    bacteria_data = []
    for x in [0.. width]
      bacteria_data[x] = []
      for y in [0.. height]
        bacteria_data[x][y] = false
    # set initial infection
    for coords in [ [1,0],[2,1],[0,2],[1,2],[2,2], [4,0] ]
      bacteria_data[ coords[0]+ 10 ][coords[1] + 10] = true

    neighbor_count = (x,y)->
      count = 0
      for this_x in [x - 1, x, x + 1]
        for this_y in [y - 1, y, y + 1]
          count += 1 if (this_x > -1) and (this_x < width) and this_y > -1 and this_y < height and bacteria_data[this_x][this_y] and ([this_x, this_y] isnt [x, y])
      count

    do generation = ()->
      next_generation = []
      for x in [0..width]
        next_generation[x] = []
        for y in [0..height]
          switch neighbor_count(x,y)
            when 2,4 then next_generation[x][y] = bacteria_data[x][y]
            when 3 then next_generation[x][y] = true
            else
              if bacteria_data[x][y] then ctx.clearRect(x*4, y*4, 4, 4)
              next_generation[x][y] = false

          ctx.fillRect(x*4, y*4, 4, 4) if next_generation[x][y] and not bacteria_data[x][y]

      bacteria_data = next_generation
      setTimeout generation, 100

  # scroll decision tree
  $('a', '.decision-tree').on "click", (e)->
    e.preventDefault()
    target = $(this).attr('href')
    $('.decision-tree').scrollTo(target, 1000)










  # timeline progress
  do time_line = ()->
    current_time = $video.currentTime()
    duration = $video.duration() || 0
    $time_bar.css {left: "#{current_time/duration * 100}%"}
    $time_elapsed.text to_clock Math.floor current_time
    $time_left.text to_clock Math.floor duration - current_time
    setTimeout time_line, 200