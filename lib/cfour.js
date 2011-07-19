
(function($) {
  var defaults = {};
  $.fn.cfour = function() {        
    return this.each(function() {
      if (this.cfour) { return false; }
      var self = {   
        initialize: function(canvas) {
          this.canvas = canvas;
          this.ctxt = canvas.getContext('2d');
          console.log(this.ctxt);
          this.animate(this.start, 10, 50);
        },

        fillEllipse: function(x, y, radius) {
          this.ctxt.beginPath();
          this.ctxt.arc(x, y, radius, 0, Math.PI*2, true);
          this.ctxt.closePath();
          this.ctxt.fill();
        },

        animate: function(callback, delay, iterations) {
          var counter = 0;
          var interval = setInterval(function() {
            counter++;
            console.log(counter);
            if (callback) { callback.call(self, counter); }
            if (counter >= iterations) { clearInterval(interval); }
          }, delay);
        },

        start: function(counter) {
          this.ctxt.fillStyle = '#fff';
          this.fillEllipse(100, 100 + (10 * (counter - 1)), 41);
          this.ctxt.fillStyle = '#00f';
          this.fillEllipse(100, 100 + (10 * counter), 40);
        }
      };
      this.cfour = self;
      self.initialize(this);      
    });
  };
})(jQuery);

$(function() {
  $('#canvas').cfour();
});
