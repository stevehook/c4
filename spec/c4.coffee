describe 'C4', ->
  beforeEach ->
    window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
      afterMove: (grid) ->
        console.log 'After move: '
        console.log grid
      }
    )
  it 'gameBoard should have been created', ->
    expect(window).toBeDefined()

