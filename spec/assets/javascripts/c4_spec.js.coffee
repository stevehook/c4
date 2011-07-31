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

  it 'mouse click on the first column should trigger a move', ->
    console.log $('#canvasOverlay')
    event = new $.Event('click')
    event.offsetX = 0
    $('#canvasOverlay').trigger(event)
    expect(gameBoard.grid).toEqual([['red'], [], [], [], [], [], []])

  it 'mouse click on the second column should trigger a move', ->
    console.log $('#canvasOverlay')
    event = new $.Event('click')
    event.offsetX = 100
    $('#canvasOverlay').trigger(event)
    expect(gameBoard.grid).toEqual([[], ['red'], [], [], [], [], []])

