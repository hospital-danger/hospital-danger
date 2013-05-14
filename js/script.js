// Generated by CoffeeScript 1.6.1
(function() {
  var to_clock, to_s, _base, _ref, _ref1;

  if ((_ref = this.console) == null) {
    this.console = {};
  }

  if ((_ref1 = (_base = this.console).log) == null) {
    _base.log = function() {};
  }

  to_s = Popcorn.util.toSeconds;

  to_clock = function(seconds) {
    var min, s;
    min = Math.floor(seconds / 60);
    s = seconds % 60;
    min = min > 9 ? "" + min : "0" + min;
    s = s > 9 ? "" + s : "0" + s;
    return "" + min + ":" + s;
  };

  $(function() {
    var $buffer_bar, $play_button, $time_bar, $time_elapsed, $time_left, $video, chapter_index, chapters, citations, cue, cues, current_time, duration, goto_chapter, time_line, toggle_play, _i, _len;
    $video = Popcorn('#the-video');
    $play_button = $('.button-play');
    $time_bar = $('.time-bar');
    $buffer_bar = $('.buffer_bar');
    $time_left = $('.time-left');
    $time_elapsed = $('.time-elapsed');
    duration = 0;
    current_time = 0;
    chapter_index = 0;
    cues = [
      {
        type: "chapter",
        title: "A Safe Place",
        target: "#safety",
        time: "00:19"
      }, {
        type: "chapter",
        title: "Quality of Care",
        target: "#quality-of-care",
        time: "00:42"
      }, {
        type: "chapter",
        title: "Deceptively Simple",
        target: "#infection",
        time: "01:09"
      }, {
        type: "chapter",
        title: "Deny & Defend",
        target: "#culpability",
        time: "01:34"
      }, {
        type: "chapter",
        title: "Malpractice in Practice",
        target: "#lawsuit",
        time: "01:59"
      }, {
        type: "chapter_end",
        time: "02:17"
      }, {
        type: "chapter",
        title: "Is It Getting Better?",
        target: "#no-improvement",
        time: "02:17"
      }
    ];
    chapters = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = cues.length; _i < _len; _i++) {
        cue = cues[_i];
        if (cue.type === "chapter") {
          _results.push(cue);
        }
      }
      return _results;
    })();
    citations = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = cues.length; _i < _len; _i++) {
        cue = cues[_i];
        if (cue.type === "citation") {
          _results.push(cue);
        }
      }
      return _results;
    })();
    for (_i = 0, _len = chapters.length; _i < _len; _i++) {
      cue = chapters[_i];
      $('ul', '.chapter-list').append("<li><a href='" + cue.target + "'>" + cue.title + "</a></li>");
    }
    toggle_play = function() {
      if ($play_button.hasClass("paused")) {
        $video.play();
      } else {
        $video.pause();
      }
      return $play_button.toggleClass("paused");
    };
    $play_button.add('#the-video').on("click", toggle_play);
    $('.progress').on("click", function(e) {
      var pos;
      pos = e.offsetX / $(this).width();
      return $video.currentTime(pos * duration);
    });
    goto_chapter = function(target) {
      var cue_time, index, _j, _len1, _ref2;
      for (index = _j = 0, _len1 = cues.length; _j < _len1; index = ++_j) {
        cue = cues[index];
        if (cue.target === target) {
          _ref2 = [index, to_s(cue.time)], chapter_index = _ref2[0], cue_time = _ref2[1];
        }
      }
      if (cue_time != null) {
        $video.currentTime(cue_time).play();
      }
      return $play_button.removeClass('paused');
    };
    $('a', '.chapter-list').on("click", function(e) {
      e.preventDefault();
      return goto_chapter($(this).attr('href'));
    });
    $(document).on("keydown", function(e) {
      var left_arrow, next_chapter, right_arrow, space_bar, _ref2;
      space_bar = 32;
      left_arrow = 37;
      right_arrow = 39;
      if (e.keyCode === space_bar) {

      } else if (e.keyCode === left_arrow) {
        e.preventDefault();
        next_chapter = Math.max(0, chapter_index - 1);
      } else if (e.keyCode === right_arrow) {
        e.preventDefault();
        next_chapter = Math.min(chapters.length - 1, chapter_index + 1);
      }
      if (next_chapter) {
        return goto_chapter((_ref2 = chapters[next_chapter]) != null ? _ref2.target : void 0);
      }
    });
    $.each(cues, function(i, cue_item) {
      return $video.cue(to_s(cue_item.time), function() {
        switch (cue_item.type) {
          case "citation":
            return $('.citations').html("<a href='" + cue_item.target + "' target='_blank'>" + cue_item.title + "</a>");
          case "chapter":
            return $('.chapter-title').show().text(cue_item.title).delay(3000).fadeOut(2000);
          case "chapter_end":
            $('.current', ".element").removeClass('current');
            $(cue_item.target).addClass('current');
            $video.pause();
            return $play_button.addClass('paused');
        }
      });
    });
    (function() {
      var $bacteria, $parent, bacteria_canvas, bacteria_data, coords, ctx, generation, height, neighbor_count, width, x, y, _j, _k, _l, _len1, _ref2;
      $bacteria = $("#bacteria");
      $parent = $bacteria.parent();
      $bacteria.attr('width', $parent.width()).attr('height', $parent.height());
      bacteria_canvas = $bacteria[0];
      ctx = bacteria_canvas.getContext("2d");
      width = $bacteria.width() / 4;
      height = $bacteria.height() / 4;
      bacteria_data = [];
      for (x = _j = 0; 0 <= width ? _j <= width : _j >= width; x = 0 <= width ? ++_j : --_j) {
        bacteria_data[x] = [];
        for (y = _k = 0; 0 <= height ? _k <= height : _k >= height; y = 0 <= height ? ++_k : --_k) {
          bacteria_data[x][y] = false;
        }
      }
      _ref2 = [[1, 0], [2, 1], [0, 2], [1, 2], [2, 2], [4, 0]];
      for (_l = 0, _len1 = _ref2.length; _l < _len1; _l++) {
        coords = _ref2[_l];
        bacteria_data[coords[0] + 10][coords[1] + 10] = true;
      }
      neighbor_count = function(x, y) {
        var count, this_x, this_y, _len2, _len3, _m, _n, _ref3, _ref4;
        count = 0;
        _ref3 = [x - 1, x, x + 1];
        for (_m = 0, _len2 = _ref3.length; _m < _len2; _m++) {
          this_x = _ref3[_m];
          _ref4 = [y - 1, y, y + 1];
          for (_n = 0, _len3 = _ref4.length; _n < _len3; _n++) {
            this_y = _ref4[_n];
            if (((-1 < this_x && this_x < width)) && ((-1 < this_y && this_y < height)) && bacteria_data[this_x][this_y] && ([this_x, this_y] !== [x, y])) {
              count += 1;
            }
          }
        }
        return count;
      };
      return generation = function() {
        var next_generation, _m, _n;
        next_generation = [];
        for (x = _m = 0; 0 <= width ? _m <= width : _m >= width; x = 0 <= width ? ++_m : --_m) {
          next_generation[x] = [];
          for (y = _n = 0; 0 <= height ? _n <= height : _n >= height; y = 0 <= height ? ++_n : --_n) {
            switch (neighbor_count(x, y)) {
              case 2:
              case 4:
                next_generation[x][y] = bacteria_data[x][y];
                break;
              case 3:
                next_generation[x][y] = true;
                if (!bacteria_data[x][y]) {
                  ctx.fillRect(x * 4, y * 4, 4, 4);
                }
                break;
              default:
                next_generation[x][y] = false;
                if (bacteria_data[x][y]) {
                  ctx.clearRect(x * 4, y * 4, 4, 4);
                }
            }
          }
        }
        bacteria_data = next_generation;
        return setTimeout(generation, 100);
      };
    })();
    $('a', '.decision-tree').on("click", function(e) {
      var target;
      e.preventDefault();
      target = $(this).attr('href');
      return $('.decision-tree').scrollTo(target, 1000);
    });
    return (time_line = function() {
      current_time = $video.currentTime();
      duration = $video.duration() || 0;
      $time_bar.css({
        left: "" + (current_time / duration * 100) + "%"
      });
      $time_elapsed.text(to_clock(Math.floor(current_time)));
      $time_left.text(to_clock(Math.floor(duration - current_time)));
      return setTimeout(time_line, 200);
    })();
  });

}).call(this);
