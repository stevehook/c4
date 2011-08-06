$( ->
  gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: ->
      gameBoard.activate false
      $.ajax {
        dataType: "json",
        type: "POST",
        #processData: false,
        contentType: "application/json",
        data: gameBoard.grid
        beforeSend: (xhr) -> xhr.setRequestHeader("X-Http-Method-Override", "PUT")
      }
  })
)
