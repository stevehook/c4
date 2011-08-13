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
    false
  end

  def is_saving_move(grid, column)
    false
  end

  def sets_up_two_in_row(grid, column)
    false
  end

  def sets_up_three_in_row(grid, column)
    false
  end
end
