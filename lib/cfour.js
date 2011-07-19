$(function() {
  var canvas = $('#canvas');
  this.ctxt = canvas[0].getContext('2d');
  this.fillEllipse = function(x, y, radius) {
    this.ctxt.beginPath();
    this.ctxt.arc(x, y, radius, 0, Math.PI*2, true);
    this.ctxt.closePath();
    this.ctxt.fill();
  }
  this.fillEllipse(100, 100, 40);
  this.animate = function(callback, delay, iterations) {
    var counter = 0;
    var interval = setInterval(function() {
      counter++;
      console.log(counter);
      if (callback) { callback(counter); }
      if (counter >= 10) { clearInterval(interval); }
    }.bind(this), delay);
  }
  this.counter = 0;
  this.interval = this.animate(null, 50, 10);
});
