$( ->
  gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: ->
      gameBoard.activate false
  })
)
