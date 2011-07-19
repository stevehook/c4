$(function() {
  var canvas = $('#canvas');
  var ctxt = canvas[0].getContext('2d');
  var fillEllipse = function(ctxt) {
    ctxt.beginPath();
    ctxt.arc(75, 75, 10, 0, Math.PI*2, true);
    ctxt.closePath();
    ctxt.fill();
  }
  fillEllipse(ctxt);
});
