/* global Popcorn:true*/

// wrap console.log
if (window.console === undefined) {
  window.console = {};
  window.console.log = function() {};
}

$(document).ready(function() {
  Popcorn('#the-video');




});