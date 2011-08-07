$( ->
  gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: ->
      gameBoard.activate false
      console.log gameBoard.grid
      $.ajax {
        dataType: "json",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify { grid: gameBoard.grid, moves: gameBoard.moves }
        beforeSend: (xhr) -> xhr.setRequestHeader("X-Http-Method-Override", "PUT")
        success: (result) ->
          console.log result
      }
  })
)
