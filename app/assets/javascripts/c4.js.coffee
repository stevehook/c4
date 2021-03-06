window.GameBoard = class GameBoard
  @defaults = { gridWidth: 7, gridHeight: 7, cellSize: 80 }
  constructor: (canvas, overlayCanvas, options) ->
    @options = $.extend GameBoard.defaults, options
    @canvas = $ canvas
    @overlayCanvas = $ overlayCanvas
    @context = @canvas[0].getContext '2d'
    @overlayContext = @overlayCanvas[0].getContext '2d'
    @reset()
    @overlayCanvas.click @clicked
    @overlayCanvas.mousemove @mouseMove
    @overlayCanvas.mouseleave @mouseLeave
    @drawFrame()
    this.initialiseGameState() if @options.grid && @options.moves

  reset: ->
    @nextColour = 0
    @highlightColumn = -1
    @grid = [[], [], [], [], [], [], []]
    @moves = []
    @active = true

  initialiseGameState: ->
    @grid = @options.grid
    @moves = @options.moves
    @drawInitialMoves()

  activate: (active) ->
    @active = active

  clicked: (e) =>
    if @active
      @activate false
      @move Math.floor(e.offsetX/@options.cellSize)

  mouseMove: (e) =>
    if @active
      highlightColumn = Math.floor e.offsetX/@options.cellSize
      if highlightColumn != @highlightColumn
        @highlight(highlightColumn)

  highlight: (column) ->
    if @highlightColumn > -1 && @highlightColumn < @options.gridWidth
      @context.globalCompositeOperation = 'copy'
      @context.fillStyle = 'rgba(0, 0, 0, 0)'
      @clearEllipse(((@highlightColumn + 1) * @options.cellSize) - (@options.cellSize/2),
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

  mouseLeave: (e) =>
    @highlight(-1)

  drawFrame: ->
    for x in [1..7]
      for y in [1..7]
        @overlayContext.fillStyle = '#444'
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

  drawInitialMoves: ->
    column = 0
    for counters in @grid
      row = 0
      for counter in counters
        @context.fillStyle = counter
        this.fillEllipse(((column + 1) * @options.cellSize) - (@options.cellSize/2),
          ((7 - row) * @options.cellSize) - (@options.cellSize/2), (@options.cellSize * 4/10))
        row++
      column++

  fillEllipse: (x, y, radius) ->
    @context.beginPath()
    @context.arc(x - 1, y - 1, radius, 0, Math.PI*2, true)
    @context.closePath()
    @context.fill()

  clearEllipse: (x, y, radius) ->
    @context.beginPath()
    @context.arc(x - 1, y - 1, radius, 0, Math.PI*2, true)
    @context.closePath()
    @context.fill()

  animateMove: (callback, delay, iterations, column, colour) ->
    counter = 0
    board = this
    afterMoveAnimation = @options.afterMoveAnimation
    interval = setInterval( ->
      counter++
      callback.call(self, counter, column, colour) if callback
      if counter >= iterations
        afterMoveAnimation() if afterMoveAnimation
        clearInterval(interval)
    , delay)

  start: (counter, column, colour) =>
    @context.globalCompositeOperation = 'copy'
    @context.fillStyle = 'rgba(0,0,0,0)'
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
    @grid[column].push colour
    @moves.push [colour, column]
    @options.afterMove(@grid) if @options.afterMove
    this.animateMove(@start, @options.cellSize/4, (7 - countersInColumn) * 4, column, colour)


