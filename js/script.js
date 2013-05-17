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
    var $buffer_bar, $play_button, $time_bar, $time_elapsed, $time_left, $video, build_chapter_markers, chapter, chapter_index, chapters, citations, cue, cues, current_time, duration, goto_chapter, node_callbacks, toggle_play, _i, _len;
    $video = Popcorn('#the-video');
    $play_button = $('.playpause');
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
        title: "",
        target: "#intro",
        time: "00:00",
        hide_title: true,
        image: '#'
      }, {
        type: "chapter",
        title: "A Safe Place?",
        target: "#chapter1",
        time: "00:20",
        image: '#',
        no_pause: true
      }, {
        type: "element",
        target: "#people",
        time: "00:33"
      }, {
        type: "element-next",
        target: "#people",
        time: "00:40"
      }, {
        type: "element",
        target: "#causes-of-death",
        time: "00:42"
      }, {
        type: "chapter",
        title: "No One Watching",
        target: "#chapter2",
        time: "00:52",
        image: '#'
      }, {
        type: "element",
        target: "#show-map",
        time: "01:11"
      }, {
        type: "chapter",
        title: "No Simple Surgery",
        target: "#chapter3",
        time: "01:33",
        image: '#'
      }, {
        type: "element",
        target: "#bacteria",
        time: "01:43"
      }, {
        type: "chapter",
        title: "Deny & Defend",
        target: "#chapter4",
        time: "02:10",
        image: '#'
      }, {
        type: "element",
        target: "#slashed-circle",
        time: "02:22"
      }, {
        type: "element",
        target: "#take-responsibility",
        time: "02:34"
      }, {
        type: "chapter",
        title: "The Malpractice Myth",
        target: "#chapter5",
        time: "02:44",
        image: '#'
      }, {
        type: "element",
        target: "#lawsuits",
        time: "02:52"
      }, {
        type: "chapter",
        title: "Result: Patient Harm",
        target: "#chapter6",
        time: "03:10",
        image: '#'
      }, {
        type: "element",
        target: "#dollar",
        time: "03:28"
      }, {
        type: "chapter",
        title: "",
        target: "#outro",
        time: "03:58",
        hide_title: true,
        image: '#'
      }, {
        type: "element",
        target: "#now-what",
        time: "03:59"
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
    build_chapter_markers = function(chapter) {
      var $el;
      $el = $("<li style='left: " + (to_s(chapter.time) / 240 * 100) + "%;'><a href='" + chapter.target + "'><img src='" + chapter.image + "'><span>" + chapter.title + "</span></a></li>");
      $('ul', '.chapter-list').append($el);
      return $video.cue(to_s(chapter.time) - 1, function() {
        if (!chapter.no_pause) {
          $video.pause();
          return $(".next-chapter").addClass("show-next");
        }
      });
    };
    for (_i = 0, _len = chapters.length; _i < _len; _i++) {
      chapter = chapters[_i];
      build_chapter_markers(chapter);
    }
    $(".next-chapter").on("click", function() {
      return $video.play();
    });
    $video.on("play", function() {
      $(".next-chapter").removeClass("show-next");
      $play_button.removeClass("paused");
      return $('aside.current').removeClass('current');
    });
    $video.on("pause", function() {
      return $play_button.addClass("paused");
    });
    toggle_play = function() {
      if ($play_button.hasClass("paused")) {
        return $video.play();
      } else {
        return $video.pause();
      }
    };
    $play_button.add('#the-video').on("click", toggle_play);
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
      $('.current-chapter').removeClass("current-chapter");
      return $("[href='" + target + "']").addClass("current-chapter");
    };
    $('a', '.chapter-list').on("click", function(e) {
      e.preventDefault();
      return goto_chapter($(this).attr('href'));
    });
    $video.on("timeupdate", function() {
      current_time = $video.currentTime();
      duration = $video.duration() || 0;
      $time_bar.css({
        left: "" + (current_time / duration * 100) + "%"
      });
      $time_elapsed.text(to_clock(Math.floor(current_time)));
      return $time_left.text(to_clock(Math.floor(duration - current_time)));
    });
    $.each(cues, function(i, cue_item) {
      return $video.cue(to_s(cue_item.time), function() {
        var _name, _name1;
        switch (cue_item.type) {
          case "citation":
            return $('.citations').html("<a href='" + cue_item.target + "' target='_blank'>" + cue_item.title + "</a>");
          case "chapter":
            $('.current').removeClass("current");
            $('.current-2').removeClass("current-2");
            if (!cue_item.hide_title) {
              $('.chapter-title').show().text(cue_item.title).delay(3000).fadeOut(2000);
            }
            $('.current-chapter').removeClass("current-chapter");
            return $("[href='" + cue_item.target + "']").addClass("current-chapter");
          case "element":
            $(cue_item.target).addClass('current');
            return typeof node_callbacks[_name = cue_item.callback] === "function" ? node_callbacks[_name]() : void 0;
          case "element-next":
            $(cue_item.target).addClass('current-2');
            return typeof node_callbacks[_name1 = cue_item.callback] === "function" ? node_callbacks[_name1]() : void 0;
        }
      });
    });
    $(".element").on("click", function(e) {
      var target;
      e.preventDefault();
      $video.pause();
      target = $(this).attr("href");
      if (target) {
        return $(target).addClass("current");
      }
    });
    $(".close-aside").on("click", function(e) {
      e.preventDefault();
      $(this).closest('aside').removeClass("current");
      return $video.play();
    });
    $('header.intro, .introduction').on("click", function() {
      $('#noise').remove();
      $('header').removeClass('intro');
      $('.introduction').addClass('finished');
      setTimeout(function() {
        return $video.play();
      }, 1000);
      return setTimeout(function() {
        return $('.introduction').hide();
      }, 5000);
    });
    node_callbacks = {};
    $(window).load(function() {
      var data, state, states, _j, _len1, _ref2, _results;
      data = window.state_data;
      states = $('#us-map')[0].contentDocument;
      _ref2 = states.getElementsByClassName("state");
      _results = [];
      for (_j = 0, _len1 = _ref2.length; _j < _len1; _j++) {
        state = _ref2[_j];
        $(state).on("mouseenter", function(e) {
          var key, left_offset, negative, positive, state_info, top_offset, value, _k, _len2, _ref3;
          _ref3 = data.states;
          for (_k = 0, _len2 = _ref3.length; _k < _len2; _k++) {
            state = _ref3[_k];
            if (state.state_abbreviation === this.id) {
              state_info = state;
            }
          }
          positive = (function() {
            var _results1;
            _results1 = [];
            for (key in state_info) {
              value = state_info[key];
              if (value === 2 && key !== "score") {
                _results1.push("<li>" + data.state_information_flags[key][value] + "</li>");
              }
            }
            return _results1;
          })();
          negative = (function() {
            var _results1;
            _results1 = [];
            for (key in state_info) {
              value = state_info[key];
              if (value === 1 && key !== "score") {
                _results1.push("<li>" + data.state_information_flags[key][value] + "</li>");
              }
            }
            return _results1;
          })();
          left_offset = e.offsetX;
          if (left_offset > 400) {
            left_offset += 50;
          }
          top_offset = e.offsetY;
          if (top_offset > 300) {
            top_offset -= 200;
          }
          $("#state-info").show().css({
            top: top_offset,
            left: left_offset
          }).find('#state-name').text(state_info.state_title);
          $('#state-positive').html(positive.join(""));
          return $('#state-negative').html(negative.join(""));
        });
        _results.push($(state).on("mouseleave", function() {
          return $('#state-info').hide();
        }));
      }
      return _results;
    });
    (function() {
      var $images, $judy, heights, image_count;
      $judy = $('#judy-gaines');
      $images = $('img', $judy);
      image_count = $images.length;
      heights = [0];
      $('.sections', $judy).find('div.section').map(function(index) {
        return heights.push($(this).height() + heights[index]);
      });
      return $('.sections', $judy).on("scroll", function() {
        var h, i, index, pos, _ref2;
        pos = $(this).scrollTop();
        index = (_ref2 = (function() {
          var _j, _len1, _ref3, _results;
          _results = [];
          for (i = _j = 0, _len1 = heights.length; _j < _len1; i = ++_j) {
            h = heights[i];
            if (((heights[i - 1] || 0) < (_ref3 = pos + 300) && _ref3 < h)) {
              _results.push(i);
            }
          }
          return _results;
        })()) != null ? _ref2 : image_count - 1;
        return $images.removeClass('current-image').eq(index - 1).addClass('current-image');
      });
    })();
    (function() {
      var $container, $deny, $events, $papers, event_count, papers_count, pos, prefix, width;
      $deny = $('#deny-and-defend');
      $container = $('.aside-content', $deny);
      $papers = $('.papers', $deny);
      $events = $('.events', $deny);
      event_count = $('.event', $deny).length;
      width = 6850;
      pos = 0;
      prefix = Modernizr.prefixed('transform');
      $.fn.parallax = function(rate) {
        var $this, update;
        $this = $(this);
        return (update = function() {
          var next_css;
          window.requestAnimationFrame(update);
          next_css = Modernizr.csstransforms3d ? "translate3d(" + (pos * rate) + "px, 0, 0)" : "translateX(" + (pos * rate) + "px)";
          return $this.css(prefix, next_css);
        })();
      };
      $('img', $papers).each(function(index) {
        $(this).parallax(index * 0.1);
        return $(this).css({
          left: index * 100
        });
      });
      $('.prev', $deny).hover(function(e) {
        return $container.scrollTo({
          top: 0,
          left: 0
        }, 7000);
      }, function() {
        return $container.stop();
      });
      $('.next', $deny).hover(function(e) {
        return $container.scrollTo({
          top: 0,
          left: width
        }, 7000);
      }, function() {
        return $container.stop();
      });
      papers_count = $('img', $papers).length;
      $('#hospital-envelope').on("click", function() {
        return $('.hospital-response').addClass("visible").on("click", function() {
          $('.visible', $deny).removeClass('visible');
          return $container.scrollLeft(0);
        });
      });
      return $container.on("scroll", function() {
        var index;
        pos = $container.scrollLeft();
        index = Math.round(pos / (width - 200) * event_count);
        return $('.event', $events).removeClass('current-event').eq(index).addClass('current-event');
      });
    })();
    $('a', '.decision-tree').on("click", function(e) {
      var target;
      e.preventDefault();
      target = $(this).attr('href');
      return $('.decision-tree').scrollTo(target, 1000);
    });
    return $('#end-decision-tree').on("click", function(e) {
      e.preventDefault();
      return $video.play();
    });
  });

}).call(this);
