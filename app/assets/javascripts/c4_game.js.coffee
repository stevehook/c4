window.Game = class Game
  constructor: (grid, moves, status, winner) ->
    @gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
      grid: grid,
      moves: moves,
      winner: winner,
      afterMoveAnimation: @afterMove
    })
    @setFinished(winner) if status == 'finished'

  afterMove: =>
    if @gameBoard.nextColour == 1
      @gameBoard.activate false
      $.ajax {
        dataType: "json",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify { grid: @gameBoard.grid, moves: @gameBoard.moves }
        beforeSend: (xhr) -> xhr.setRequestHeader("X-Http-Method-Override", "PUT")
        success: (result) =>
          new_move = result.moves[result.moves.length - 1]
          if result.status == 'finished'
            @gameBoard.move new_move[1] if result.winner == 'yellow'
            this.setFinished(result.winner)
          else
            @gameBoard.move new_move[1]
            @gameBoard.activate true
      }

  setFinished: (winner) ->
    if winner
      $('.messagePanel').text "Game over, #{winner} won"
    else
      $('.messagePanel').text "Game over, drawn"
    @gameBoard.activate false

