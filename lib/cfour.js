(function($) {
  var defaults = {};
  $.fn.cfour = function() {        
    return this.each(function() {
      if (this.cfour) { return false; }
      var self = {   
        initialize: function(canvas) {
          this.grid = [[], [], [], [], [], [], []];
          this.canvas = $(canvas);
          this.ctxt = canvas.getContext('2d');
          console.log(this.ctxt);
          this.nextColour = 0;
          this.canvas.click(this.clicked);
        },

        clicked: function(e) {
          self.move(Math.floor(e.offsetX/100));
        },

        fillEllipse: function(x, y, radius) {
          this.ctxt.beginPath();
          this.ctxt.arc(x, y, radius, 0, Math.PI*2, true);
          this.ctxt.closePath();
          this.ctxt.fill();
        },

        animate: function(callback, delay, iterations, column, colour, onFinish) {
          var counter = 0;
          var interval = setInterval(function() {
            counter++;
            if (callback) { callback.call(self, counter, column, colour); }
            if (counter >= iterations) { 
              clearInterval(interval);
              if (onFinish) { onFinish.call(self); }
            }
          }, delay);
        },

        start: function(counter, column, colour) {
          this.ctxt.fillStyle = '#fff';
          this.fillEllipse((column + 1) * 100, (25 * (counter - 1)) - 50, 41);
          this.ctxt.fillStyle = colour;
          this.fillEllipse((column + 1) * 100, (25 * counter) - 50, 40);
        },

        move: function(column, onFinish) {
          if (this.nextColour == 0) {
            colour = 'red';
            this.nextColour = 1;
          } else {
            colour = 'yellow';
            this.nextColour = 0;
          }
          // TODO: Add a counter to the grid
          var countersInColumn = this.grid[column].length;
          this.grid[column].push(colour);
          this.animate(this.start, 25, (7 - countersInColumn) * 4, column, colour, onFinish);
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
