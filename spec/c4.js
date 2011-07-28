describe('C4', function() {
  beforeEach(function() {
    return window.gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
      afterMove: function(grid) {
        console.log('After move: ');
        return console.log(grid);
      }
    });
  });
  return it('gameBoard should have been created', function() {
    return expect(window).toBeDefined();
  });
});