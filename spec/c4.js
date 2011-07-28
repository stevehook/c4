describe('C4', function() {
  beforeEach(function() {
    return window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {});
  });
  return it('gameBoard should have been created', function() {
    return expect(window.gameBoard).toBeDefined();
  });
});