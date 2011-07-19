$(function() {
  var canvas = $('#canvas');
  this.ctxt = canvas[0].getContext('2d');
  this.fillEllipse = function(x, y, radius) {
    this.ctxt.beginPath();
    this.ctxt.arc(x, y, radius, 0, Math.PI*2, true);
    this.ctxt.closePath();
    this.ctxt.fill();
  }
  this.animate = function(callback, delay, iterations) {
    var counter = 0;
    var interval = setInterval(function() {
      counter++;
      console.log(counter);
      if (callback) { callback(counter); }
      if (counter >= iterations) { clearInterval(interval); }
    }.bind(this), delay);
  }
  this.animate(function(counter) {
    this.ctxt.fillStyle = '#fff';
    this.fillEllipse(100, 100 + (10 * (counter - 1)), 41);
    this.ctxt.fillStyle = '#00f';
    this.fillEllipse(100, 100 + (10 * counter), 40);
  }.bind(this), 10, 50);
});
