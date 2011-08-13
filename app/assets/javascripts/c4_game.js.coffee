window.Game = class Game
  constructor: (grid, moves, status) ->
    console.log 'Game ctor'
    @gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
      grid: grid,
      moves: moves,
      afterMove: $.proxy(this.afterMove, this)
    })

  afterMove: ->
    gameBoard = @gameBoard
    console.log 'afterMove'
    if gameBoard.nextColour == 1
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
          new_move = result.moves[result.moves.length - 1]
          if result.status == 'finished'
            console.log 'Game over!'
            $('.messagePanel').text 'Game over'
          else
            gameBoard.move new_move[1]
            gameBoard.activate true
      }

$( ->
  game = new Game()
  # gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
  #   afterMove: ->
  #     if gameBoard.nextColour == 1
  #       gameBoard.activate false
  #       console.log gameBoard.grid
  #       $.ajax {
  #         dataType: "json",
  #         type: "POST",
  #         contentType: "application/json",
  #         data: JSON.stringify { grid: gameBoard.grid, moves: gameBoard.moves }
  #         beforeSend: (xhr) -> xhr.setRequestHeader("X-Http-Method-Override", "PUT")
  #         success: (result) ->
  #           console.log result
  #           new_move = result.moves[result.moves.length - 1]
  #           if result.status == 'finished'
  #             console.log 'Game over!'
  #             $('.messagePanel').text 'Game over'
  #           else
  #             gameBoard.move new_move[1]
  #             gameBoard.activate true
  #     }
  # })
)

