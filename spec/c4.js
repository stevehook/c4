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
  it('second move in the same column should be in second row', function() {
    gameBoard.move(0);
    gameBoard.move(0);
    return expect(gameBoard.grid).toEqual([['red', 'yellow'], [], [], [], [], [], []]);
  });
  it('mouse click on the first column should trigger a move', function() {
    var event;
    console.log($('#canvasOverlay'));
    event = new $.Event('click');
    event.offsetX = 0;
    $('#canvasOverlay').trigger(event);
    return expect(gameBoard.grid).toEqual([['red'], [], [], [], [], [], []]);
  });
  return it('mouse click on the second column should trigger a move', function() {
    var event;
    console.log($('#canvasOverlay'));
    event = new $.Event('click');
    event.offsetX = 100;
    $('#canvasOverlay').trigger(event);
    return expect(gameBoard.grid).toEqual([[], ['red'], [], [], [], [], []]);
  });
});