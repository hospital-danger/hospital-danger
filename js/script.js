// console.log wrapper
if (window.console === undefined) {
  window.console = {};
  window.console.log = function() {};
}