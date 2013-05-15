node_callbacks.bacteria = ()->
  coords_list = [ [1,0],[2,1],[0,2],[1,2],[2,2], [4,0] ]
  bacteriafy( "#bacteria", coords_list )





bacteriafy = (selector, coords_list)->
  $bacteria = $(selector)
  bacteria_canvas = $bacteria[0]
  ctx = bacteria_canvas.getContext "2d"
  ctx.clearRect(0,0,bacteria_canvas.width,bacteria_canvas.height)
  width = bacteria_canvas.width / 4
  height = bacteria_canvas.height / 4
  generation_count = 0
  # initialize data
  bacteria_data = []
  for x in [0.. width]
    bacteria_data[x] = []
    for y in [0.. height]
      bacteria_data[x][y] = false
  # set initial infection
  for coords in coords_list
    bacteria_data[ coords[0] + 75 ][ coords[1] + 55 ] = true

  neighbor_count = (x,y)->
    count = 0
    for this_x in [x - 1, x, x + 1]
      for this_y in [y - 1, y, y + 1]
        count += 1 if (-1 < this_x < width) and (-1 < this_y < height) and bacteria_data[this_x][this_y] and ([this_x, this_y] isnt [x, y])
    count

  do generation = ()->
    unless $video.paused()
      generation_count += 1
      next_generation = []
      for x in [0..width]
        next_generation[x] = []
        for y in [0..height]
          switch neighbor_count(x,y)
            when 4 then next_generation[x][y] = bacteria_data[x][y]
            when 3
              next_generation[x][y] = true
              ctx.fillRect(x*4, y*4, 4, 4) if not bacteria_data[x][y]
            when 2
              if generation_count < 150 or generation_count % 3 is 0
                next_generation[x][y] = bacteria_data[x][y]
              else
                next_generation[x][y] = false
                if bacteria_data[x][y] then ctx.clearRect(x*4, y*4, 4, 4)
            else
              next_generation[x][y] = false
              if bacteria_data[x][y] then ctx.clearRect(x*4, y*4, 4, 4)

      bacteria_data = next_generation
    setTimeout generation, 150