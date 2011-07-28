describe 'C4', ->
  beforeEach ->
    window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), { })
  it 'gameBoard should have been created', ->
    expect(window.gameBoard).toBeDefined()

