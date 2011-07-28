describe 'C4', ->
  beforeEach ->
    window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), { })
  it 'gameBoard should have been created', ->
    expect(gameBoard).toBeDefined()
  it 'first move should be red', ->
    gameBoard.move 0
    expect(gameBoard.grid).toEqual([['red'], [], [], [], [], [], []])
  it 'second move should be yellow', ->
    gameBoard.move 0
    gameBoard.move 1
    expect(gameBoard.grid).toEqual([['red'], ['yellow'], [], [], [], [], []])
  it 'second move in the same column should be in second row', ->
    gameBoard.move 0
    gameBoard.move 0
    expect(gameBoard.grid).toEqual([['red', 'yellow'], [], [], [], [], [], []])

