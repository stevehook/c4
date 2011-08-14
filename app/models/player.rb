class Player
  def initialize(colour)
    @colour = colour
  end
  
  def get_next_move(grid)
    # TODO: Do something clever here...
    best_score = 0
    best_column = -1
    scores = (0..6).each do |column|
      grid_copy = Game.copy_grid(grid)
      score = score_for_column(grid_copy, column)
      if score > best_score
        best_score = score
        best_column = column
      end
    end
    best_column
  end

  # score moves on a scale from 0 to 100. Higher numbers are better, 0 implies an illegal move.
  def score_for_column(grid, column)
    return 0 if is_column_full(grid, column)
    return 100 if is_winning_move(grid, column)
    return 99 if is_saving_move(grid, column)
    return 50 if sets_up_three_in_row(grid, column)
    return 25 if sets_up_two_in_row(grid, column)
    # Otherwise favour columns near the centre
    return column if column <= 3
    return (6 - column) if column > 3
  end

  def is_column_full(grid, column)
    grid[column].length >= 7
  end

  def is_winning_move(grid, column)
    new_grid, row = apply_move(grid, column, @colour)
    has_connect_four(new_grid, @colour)
  end

  def apply_move(grid, column, colour = @colour)
    new_grid = Game.copy_grid(grid)
    array = new_grid[column]
    first_empty_row = array.length
    array << colour
    return new_grid, first_empty_row
  end

  def is_saving_move(grid, column)
    new_grid, row = apply_move(grid, column, opposing_colour)
    has_connect_four(new_grid, opposing_colour)
  end

  def opposing_colour
    @colour == 'red' ? 'yellow' : 'red'
  end

  def sets_up_two_in_row(grid, column)
    false
  end

  def sets_up_three_in_row(grid, column)
  end

  def has_connect_four(grid, colour)
    has_horizontal_line(grid, colour) || has_vertical_line(grid, colour) || has_diagonal_line(grid, colour)
  end

  def has_diagonal_line(grid, colour)
    (-3..3).each do |x|
      return true if has_diagonal(grid, colour, x, 1)
    end
    (3..9).each do |x|
      return true if has_diagonal(grid, colour, x, -1)
    end
    false
  end

  def has_horizontal_line(grid, colour)
    (0..6).each do |x|
      return true if has_straight_line(grid, colour, x, true)
    end
    false
  end

  def has_vertical_line(grid, colour)
    (0..6).each do |y|
      return true if has_straight_line(grid, colour, y, false)
    end
    false
  end

  def has_straight_line(grid, colour, a, horizonal)
    counter = 0
    (0..6).each do |b|
      value = horizonal ? grid_value(grid, a, b) : grid_value(grid, b, a)
      if value == colour
        counter += 1
      else
        counter = 0
      end
      return true if counter == 4
    end
    false
  end

  def has_diagonal(grid, colour, x, direction)
    counter = 0
    (0..6).each do |y|
      if grid_value(grid, x + (direction * y), y) == colour
        counter += 1
      else
        counter = 0
      end
      return true if counter == 4
    end
    false
  end

  def grid_value(grid, x, y)
    return nil if x < 0 || x >= 7 || y < 0 || y >= 7
    stack = grid[y]
    stack.length > x ? stack[x] : nil
  end
end
