var GameBoard = function(canvas, overlayCanvas, options) { 
  this.defaults = { gridWidth: 7, gridHeight: 7, cellSize: 80 },
  
  this.initialise = function(canvas, overlayCanvas) {
    this.options = this.defaults;
    this.grid = [[], [], [], [], [], [], []];
    this.canvas = $(canvas);
    this.overlayCanvas = $(overlayCanvas);
    this.ctxt = this.canvas[0].getContext('2d');
    this.overlayCtxt = this.overlayCanvas[0].getContext('2d');
    this.nextColour = 0;
    this.overlayCanvas.click($.proxy(this.clicked, this));
    this.drawFrame();
    console.log(this.defaults);
  },
  
  this.clicked = function(e) {
    this.move(Math.floor(e.offsetX/this.options.cellSize));
  },

  this.drawFrame = function() {
    for (var x = 1; x <= 7; x++) {
      for (var y = 1; y <= 7; y++) {
        this.overlayCtxt.fillStyle = '#00f';
        this.overlayCtxt.beginPath();
        this.overlayCtxt.arc((x * this.options.cellSize) - (this.options.cellSize/2), 
          (y * this.options.cellSize) - (this.options.cellSize/2), 
          this.options.cellSize * 4/10, 0, Math.PI*2, true);
        this.overlayCtxt.moveTo((x - 1) * this.options.cellSize, (y - 1) * this.options.cellSize);
        this.overlayCtxt.lineTo(x * this.options.cellSize, (y - 1) * this.options.cellSize);
        this.overlayCtxt.lineTo(x * this.options.cellSize, y * this.options.cellSize);
        this.overlayCtxt.lineTo((x - 1) * this.options.cellSize, y * this.options.cellSize);
        this.overlayCtxt.lineTo((x - 1) * this.options.cellSize, (y - 1) * this.options.cellSize);
        this.overlayCtxt.closePath();
        this.overlayCtxt.fill();
      }
    }
  },

  this.fillEllipse = function(x, y, radius) {
    this.ctxt.beginPath();
    this.ctxt.arc(x - 1, y - 1, radius, 0, Math.PI*2, true);
    this.ctxt.closePath();
    this.ctxt.fill();
  },

  this.animate = function(callback, delay, iterations, column, colour, onFinish) {
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

  this.start = function(counter, column, colour) {
    this.ctxt.fillStyle = '#fff';
    this.fillEllipse(((column + 1) * this.options.cellSize) - (this.options.cellSize/2), 
      ((this.options.cellSize/4) * (counter - 1)) - (this.options.cellSize/2), (this.options.cellSize * 4/10) + 1);
    this.ctxt.fillStyle = colour;
    this.fillEllipse(((column + 1) * this.options.cellSize) - (this.options.cellSize/2), 
      ((this.options.cellSize/4) * counter) - (this.options.cellSize/2), (this.options.cellSize * 4/10));
  },

  this.move = function(column, onFinish) {
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
    this.animate($.proxy(this.start, this), this.options.cellSize/4, (7 - countersInColumn) * 4, column, colour, onFinish);
  }

  this.initialise(canvas, overlayCanvas);
};

$(function() {
  var gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'));
});
