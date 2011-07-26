GameBoard = (canvas, overlayCanvas, options) ->
  this.defaults = { gridWidth: 7, gridHeight: 7, cellSize: 80 }

$( ->
  gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: (grid) ->
      console.log('After move: ')
      console.log(grid)
    }
  )
)
