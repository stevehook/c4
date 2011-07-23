(function($) {
  var defaults = {};
  $.fn.cfour = function() {        
    return this.each(function() {
      if (this.cfour) { return false; }
      var self = { 
        initialize: function(canvas) {
          this.grid = [[], [], [], [], [], [], []];
          this.canvas = $(canvas);
          this.overlayCanvas = $('#' + canvas.id + 'Overlay');
          this.ctxt = canvas.getContext('2d');
          this.overlayCtxt = this.overlayCanvas[0].getContext('2d');
          this.nextColour = 0;
          this.overlayCanvas.click(this.clicked);
          this.drawFrame();
        },

        clicked: function(e) {
          self.move(Math.floor(e.offsetX/100));
        },

        drawFrame: function() {
          for (var x = 1; x <= 7; x++) {
            for (var y = 1; y <= 7; y++) {
              console.log(x + ' ' + y);
              this.overlayCtxt.fillStyle = '#00f';
              this.overlayCtxt.beginPath();
              this.overlayCtxt.arc((x * 100) - 50, (y * 100) - 50, 40, 0, Math.PI*2, true);
              this.overlayCtxt.moveTo((x - 1) * 100, (y - 1) * 100);
              this.overlayCtxt.lineTo(x * 100, (y - 1) * 100);
              this.overlayCtxt.lineTo(x * 100, y * 100);
              this.overlayCtxt.lineTo((x - 1) * 100, y * 100);
              this.overlayCtxt.lineTo((x - 1) * 100, (y - 1) * 100);
              this.overlayCtxt.closePath();
              this.overlayCtxt.fill();
            }
          }
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
          this.fillEllipse(((column + 1) * 100) - 50, (25 * (counter - 1)) - 50, 41);
          this.ctxt.fillStyle = colour;
          this.fillEllipse(((column + 1) * 100) - 50, (25 * counter) - 50, 40);
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
          if (countersInColumn >= 7) { return; }
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
