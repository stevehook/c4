var GameBoard;
GameBoard = (function() {
  GameBoard.defaults = {
    gridWidth: 7,
    gridHeight: 7,
    cellSize: 80
  };
  function GameBoard(canvas, overlayCanvas, options) {
    this.options = $.extend(GameBoard.defaults, options);
    this.grid = [[], [], [], [], [], [], []];
    this.canvas = $(canvas);
    this.overlayCanvas = $(overlayCanvas);
    this.context = this.canvas[0].getContext('2d');
    this.overlayContext = this.overlayCanvas[0].getContext('2d');
    this.nextColour = 0;
    this.overlayCanvas.click($.proxy(this.clicked, this));
    this.overlayCanvas.mousemove($.proxy(this.mouseMove, this));
    this.overlayCanvas.mouseleave($.proxy(this.mouseLeave, this));
    this.highlightColumn = -1;
    this.drawFrame();
  }
  GameBoard.prototype.clicked = function(e) {
    return this.move(Math.floor(e.offsetX / this.options.cellSize));
  };
  GameBoard.prototype.mouseMove = function(e) {
    var highlightColumn;
    highlightColumn = Math.floor(e.offsetX / this.options.cellSize);
    if (highlightColumn !== this.highlightColumn) {
      this.highlight(highlightColumn);
      return console.log('highlight column ' + this.highlightColumn);
    }
  };
  GameBoard.prototype.highlight = function(column) {
    if (this.highlightColumn > -1 && this.highlightColumn < this.options.gridWidth) {
      this.context.fillStyle = '#fff';
      this.fillEllipse(((this.highlightColumn + 1) * this.options.cellSize) - (this.options.cellSize / 2), ((this.options.gridHeight - this.grid[this.highlightColumn].length) * this.options.cellSize) - (this.options.cellSize / 2), (this.options.cellSize * 4 / 10) + 1);
    }
    if (this.nextColour === 0) {
      this.context.fillStyle = "rgba(255, 0, 0, 0.25)";
    } else {
      this.context.fillStyle = "rgba(255, 255, 0, 0.25)";
    }
    this.highlightColumn = column;
    return this.fillEllipse(((this.highlightColumn + 1) * this.options.cellSize) - (this.options.cellSize / 2), ((this.options.gridHeight - this.grid[this.highlightColumn].length) * this.options.cellSize) - (this.options.cellSize / 2), (this.options.cellSize * 4 / 10) + 1);
  };
  GameBoard.prototype.mouseLeave = function(e) {
    return console.log('mouseLeave');
  };
  GameBoard.prototype.drawFrame = function() {
    var x, y, _results;
    _results = [];
    for (x = 1; x <= 7; x++) {
      _results.push((function() {
        var _results2;
        _results2 = [];
        for (y = 1; y <= 7; y++) {
          this.overlayContext.fillStyle = '#00f';
          this.overlayContext.beginPath();
          this.overlayContext.arc((x * this.options.cellSize) - (this.options.cellSize / 2), (y * this.options.cellSize) - (this.options.cellSize / 2), this.options.cellSize * 4 / 10, 0, Math.PI * 2, true);
          this.overlayContext.moveTo((x - 1) * this.options.cellSize, (y - 1) * this.options.cellSize);
          this.overlayContext.lineTo(x * this.options.cellSize, (y - 1) * this.options.cellSize);
          this.overlayContext.lineTo(x * this.options.cellSize, y * this.options.cellSize);
          this.overlayContext.lineTo((x - 1) * this.options.cellSize, y * this.options.cellSize);
          this.overlayContext.lineTo((x - 1) * this.options.cellSize, (y - 1) * this.options.cellSize);
          this.overlayContext.closePath();
          _results2.push(this.overlayContext.fill());
        }
        return _results2;
      }).call(this));
    }
    return _results;
  };
  GameBoard.prototype.fillEllipse = function(x, y, radius) {
    this.context.beginPath();
    this.context.arc(x - 1, y - 1, radius, 0, Math.PI * 2, true);
    this.context.closePath();
    return this.context.fill();
  };
  GameBoard.prototype.animateMove = function(callback, delay, iterations, column, colour) {
    var board, counter, interval;
    counter = 0;
    board = this;
    return interval = setInterval(function() {
      counter++;
      if (callback) {
        callback.call(self, counter, column, colour);
      }
      if (counter >= iterations) {
        clearInterval(interval);
        if (board.options.afterMove) {
          return board.options.afterMove(board.grid);
        }
      }
    }, delay);
  };
  GameBoard.prototype.start = function(counter, column, colour) {
    this.context.fillStyle = '#fff';
    this.fillEllipse(((column + 1) * this.options.cellSize) - (this.options.cellSize / 2), ((this.options.cellSize / 4) * (counter - 1)) - (this.options.cellSize / 2), (this.options.cellSize * 4 / 10) + 1);
    this.context.fillStyle = colour;
    return this.fillEllipse(((column + 1) * this.options.cellSize) - (this.options.cellSize / 2), ((this.options.cellSize / 4) * counter) - (this.options.cellSize / 2), this.options.cellSize * 4 / 10);
  };
  GameBoard.prototype.move = function(column) {
    var colour, countersInColumn;
    if (this.nextColour === 0) {
      colour = 'red';
      this.nextColour = 1;
    } else {
      colour = 'yellow';
      this.nextColour = 0;
    }
    countersInColumn = this.grid[column].length;
    if (countersInColumn >= 7) {
      return;
    }
    this.grid[column].push(colour);
    return this.animateMove($.proxy(this.start, this), this.options.cellSize / 4, (7 - countersInColumn) * 4, column, colour);
  };
  return GameBoard;
})();
$(function() {
  var gameBoard;
  return gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: function(grid) {
      console.log('After move: ');
      return console.log(grid);
    }
  });
});