class GameBoard
  @defaults = { gridWidth: 7, gridHeight: 7, cellSize: 80 }
  constructor: (canvas, overlayCanvas, options) ->
    @options = $.extend(@defaults, options)
    @grid = [[], [], [], [], [], [], []]
    @canvas = $ canvas
    @overlayCanvas = $ overlayCanvas
    @ctxt = @canvas[0].getContext '2d'
    @overlayCtxt = @overlayCanvas[0].getContext '2d'
    @nextColour = 0
    @overlayCanvas.click $.proxy(this.clicked, this)
    @drawFrame()

  clicked: (e) ->
    this.move Math.floor(e.offsetX/@options.cellSize)

  drawFrame: ->
    for x in [1..7]
      for y in [1..7]
        @overlayContext.fillStyle = '#00f'
        @overlayContext.beginPath()
        @overlayContext.arc((x * @options.cellSize) - (@options.cellSize/2), 
          (y * @options.cellSize) - (@options.cellSize/2), 
          @options.cellSize * 4/10, 0, Math.PI*2, true)
        @overlayContext.moveTo((x - 1) * @options.cellSize, (y - 1) * @options.cellSize)
        @overlayContext.lineTo(x * @options.cellSize, (y - 1) * @options.cellSize)
        @overlayContext.lineTo(x * @options.cellSize, y * @options.cellSize)
        @overlayContext.lineTo((x - 1) * @options.cellSize, y * @options.cellSize)
        @overlayContext.lineTo((x - 1) * @options.cellSize, (y - 1) * @options.cellSize)
        @overlayContext.closePath()
        @overlayContext.fill()

  fillEllipse: (x, y, radius) ->
    @context.beginPath()
    @context.arc(x - 1, y - 1, radius, 0, Math.PI*2, true)
    @context.closePath()
    @context.fill()

  animateMove: (callback, delay, iterations, column, colour) ->
    counter = 0
    board = this
    interval = setInterval( ->
      counter++
      callback.call(self, counter, column, colour) if callback
      if counter >= iterations
        clearInterval(interval)
        board.options.afterMove(board.grid) if board.options.afterMove
    , delay)

  start: (counter, column, colour) ->
    @context.fillStyle = '#fff'
    this.fillEllipse(((column + 1) * @options.cellSize) - (@options.cellSize/2), 
      ((@options.cellSize/4) * (counter - 1)) - (@options.cellSize/2), (@options.cellSize * 4/10) + 1)
    @context.fillStyle = colour
    this.fillEllipse(((column + 1) * @options.cellSize) - (@options.cellSize/2), 
      ((@options.cellSize/4) * counter) - (@options.cellSize/2), (@options.cellSize * 4/10))

  move: (column) ->
    if (@nextColour == 0)
      colour = 'red'
      @nextColour = 1
    else
      colour = 'yellow'
      @nextColour = 0
    countersInColumn = @grid[column].length
    return if (countersInColumn >= 7)
    @grid[column].push(colour)
    this.animateMove($.proxy(this.start, this), @options.cellSize/4, (7 - countersInColumn) * 4, column, colour)

$ ->
  gameBoard = new GameBoard($('#canvas'), $('#canvasOverlay'), {
    afterMove: (grid) ->
      console.log 'After move: '
      console.log grid
    }
  )
