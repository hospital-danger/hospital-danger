if ( !window.requestAnimationFrame ) {

  window.requestAnimationFrame = ( function() {

    return window.webkitRequestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.oRequestAnimationFrame ||
    window.msRequestAnimationFrame ||
    function( /* function FrameRequestCallback */ callback, /* DOMElement Element */ element ) {
      if (isSafari() || isFfx())
        window.setTimeout( callback, 1000 / 60 )
      else
        window.setTimeout( callback, 1000 / 90 );
    };
  } )();
}