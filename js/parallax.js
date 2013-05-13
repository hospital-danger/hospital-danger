/* globals Modernizr:true */

$(function(){
  var prefix = Modernizr.prefixed('transform');

  $.fn.parallax = function(speedFactor) {
    var $this = $(this), $parent = $(this).closest('section'), top, height;

    function setTop(){
      top = $parent.offset().top;
      height = $parent.height();
    }

    function update(){
      window.requestAnimationFrame(update);

      var nextPos = ((top - pos) * speedFactor);
      if (Modernizr.csstransforms3d){
        $this.css(prefix, 'translate3d(0,' + nextPos + 'px, 0)');
      } else {
        $this.css(prefix, 'translateY(' + nextPos + 'px)');
      }
    }

    initResize(setTop);
    update();
  };

  var $window = $(window);
  var windowHeight, windowWidth, pos;

  function initResize(callback){
    callback();
    $window.resize(callback);
  }

  function windowInit(){
    windowHeight = $window.height();
    windowWidth = $window.width();
    pos = $window.scrollTop();
  }

  windowInit();

});