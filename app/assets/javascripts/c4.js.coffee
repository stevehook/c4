window.GameBoard = class GameBoard
  @defaults = { gridWidth: 7, gridHeight: 7, cellSize: 80 }
  constructor: (canvas, overlayCanvas, options) ->
    console.log 'creating new Gameboard'
    @options = $.extend GameBoard.defaults, options
    @canvas = $ canvas
    @overlayCanvas = $ overlayCanvas
    @context = @canvas[0].getContext '2d'
    @overlayContext = @overlayCanvas[0].getContext '2d'
    @reset()
    @overlayCanvas.click $.proxy(this.clicked, this)
    @overlayCanvas.mousemove $.proxy(this.mouseMove, this)
    @overlayCanvas.mouseleave $.proxy(this.mouseLeave, this)
    @drawFrame()

  reset: ->
    @nextColour = 0
    @highlightColumn = -1
    @grid = [[], [], [], [], [], [], []]
    @active = true

  activate: (active) ->
    @active = active

  clicked: (e) ->
    @move Math.floor(e.offsetX/@options.cellSize) if @active

  mouseMove: (e) ->
    if @active
      highlightColumn = Math.floor e.offsetX/@options.cellSize
      if highlightColumn != @highlightColumn
        @highlight(highlightColumn)

  highlight: (column) ->
    if @highlightColumn > -1 && @highlightColumn < @options.gridWidth
      @context.fillStyle = '#fff'
      @fillEllipse(((@highlightColumn + 1) * @options.cellSize) - (@options.cellSize/2),
        ((@options.gridHeight - @grid[@highlightColumn].length) * @options.cellSize) - (@options.cellSize/2),
        (@options.cellSize * 4/10) + 1)
    @highlightColumn = column
    if column > -1
      if @nextColour == 0
        @context.fillStyle = "rgba(255, 0, 0, 0.25)"
      else
        @context.fillStyle = "rgba(255, 255, 0, 0.25)"
      @fillEllipse(((@highlightColumn + 1) * @options.cellSize) - (@options.cellSize/2),
        ((@options.gridHeight - @grid[@highlightColumn].length) * @options.cellSize) - (@options.cellSize/2),
        (@options.cellSize * 4/10) + 1)

  mouseLeave: (e) ->
    @highlight(-1)

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


