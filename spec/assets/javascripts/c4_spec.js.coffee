describe 'C4', ->
  beforeEach ->
    window.moves = 0
    if !window.gameBoard
      window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), { afterMove: -> window.moves++ })
    window.gameBoard.reset()

  it 'gameBoard should have been created', ->
    expect(gameBoard).toBeDefined()

  it 'first move should be red', ->
    gameBoard.move 0
    expect(gameBoard.grid).toEqual [['red'], [], [], [], [], [], []]
    expect(gameBoard.moves).toEqual [['red', 0]]

  it 'second move should be yellow', ->
    gameBoard.move 0
    gameBoard.move 1
    expect(gameBoard.grid).toEqual [['red'], ['yellow'], [], [], [], [], []]
    expect(gameBoard.moves).toEqual [['red', 0], ['yellow', 1]]

  it 'second move in the same column should be in second row', ->
    gameBoard.move 0
    gameBoard.move 0
    expect(gameBoard.grid).toEqual [['red', 'yellow'], [], [], [], [], [], []]
    expect(gameBoard.moves).toEqual [['red', 0], ['yellow', 0]]

  it 'mouse click on the first column should trigger a move', ->
    event = new $.Event('click')
    event.offsetX = 0
    $('#canvasOverlay').trigger(event)
    expect(gameBoard.grid).toEqual [['red'], [], [], [], [], [], []]
    expect(gameBoard.moves).toEqual [['red', 0]]

  it 'mouse click on the second column should trigger a move', ->
    event = new $.Event('click')
    event.offsetX = 100
    $('#canvasOverlay').trigger(event)
    expect(gameBoard.grid).toEqual [[], ['red'], [], [], [], [], []]
    expect(gameBoard.moves).toEqual [['red', 1]]

  it 'move should trigger afterMove event', ->
    event = new $.Event('click')
    event.offsetX = 100
    expect(window.moves).toEqual(0)
    $('#canvasOverlay').trigger(event)
    expect(window.moves).toEqual(1)

  it 'activate can be used to make the board unresponsive to click events', ->
    gameBoard.activate false
    event = new $.Event('click')
    event.offsetX = 0
    $('#canvasOverlay').trigger(event)
    expect(gameBoard.grid).toEqual [[], [], [], [], [], [], []]
    expect(gameBoard.moves).toEqual []

