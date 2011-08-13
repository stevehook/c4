window.Game = class Game
  constructor: (grid, moves, status, winner) ->
    console.log 'Game ctor'
    @gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
      grid: grid,
      moves: moves,
      winner: winner,
      afterMove: $.proxy(this.afterMove, this)
    })
    @setFinished(winner) if status == 'finished'

  afterMove: ->
    gameBoard = @gameBoard
    console.log 'afterMove'
    if gameBoard.nextColour == 1
      gameBoard.activate false
      console.log gameBoard.grid
      game = this
      $.ajax {
        dataType: "json",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify { grid: gameBoard.grid, moves: gameBoard.moves }
        beforeSend: (xhr) -> xhr.setRequestHeader("X-Http-Method-Override", "PUT")
        success: (result) ->
          console.log result
          new_move = result.moves[result.moves.length - 1]
          if result.status == 'finished'
            game.setFinished(result.winner)
          else
            gameBoard.move new_move[1]
            gameBoard.activate true
      }

  setFinished: (winner) ->
    if winner
      $('.messagePanel').text "Game over, #{winner} won"
    else
      $('.messagePanel').text "Game over, drawn"
    @gameBoard.activate false

