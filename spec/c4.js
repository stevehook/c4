describe('C4', function() {
  beforeEach(function() {
    return window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {});
  });
  it('gameBoard should have been created', function() {
    return expect(gameBoard).toBeDefined();
  });
  it('first move should be red', function() {
    gameBoard.move(0);
    return expect(gameBoard.grid).toEqual([['red'], [], [], [], [], [], []]);
  });
  it('second move should be yellow', function() {
    gameBoard.move(0);
    gameBoard.move(1);
    return expect(gameBoard.grid).toEqual([['red'], ['yellow'], [], [], [], [], []]);
  });
  return it('second move in the same column should be in second row', function() {
    gameBoard.move(0);
    gameBoard.move(0);
    return expect(gameBoard.grid).toEqual([['red', 'yellow'], [], [], [], [], [], []]);
  });
});