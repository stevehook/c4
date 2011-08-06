$( ->
  window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: ->
      console.log 'moved!!!!'
  })
)
