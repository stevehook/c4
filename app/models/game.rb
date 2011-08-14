class Game < ActiveRecord::Base
  after_initialize :init
  after_find :after_find
  before_save :before_save
  after_save :after_save

  def self.copy_grid(grid)
    new_grid = []
    grid.each { |array| new_grid.push(array.clone) }
    new_grid
  end

  def init
    if new_record?
      self.status = :in_play
      self.moves = []
      self.grid = [[],[],[],[],[],[],[]]
    end
  end

  def evaluate_status
    evaluate_winner(last_colour)
    evaluate_game_over
  end

  def last_colour
    self.moves.last[0]
  end

  def evaluate_winner(colour)
    self.winner = colour if has_connect_four(colour)
  end

  def evaluate_game_over
    self.status = :finished if self.winner
  end

  def has_connect_four(colour)
    has_horizontal_line(colour) || has_vertical_line(colour) || has_diagonal_line(colour)
  end

  def has_horizontal_line(colour)
    (0..6).each do |x|
      return true if has_straight_line(colour, x, true)
    end
    false
  end

  def has_vertical_line(colour)
    (0..6).each do |y|
      return true if has_straight_line(colour, y, false)
    end
    false
  end

  def has_diagonal_line(colour)
    (-3..3).each do |x|
      return true if has_diagonal(colour, x, 1)
    end
    (3..9).each do |x|
      return true if has_diagonal(colour, x, -1)
    end
    false
  end

  def has_straight_line(colour, a, horizonal)
    counter = 0
    (0..6).each do |b|
      value = horizonal ? grid_value(a, b) : grid_value(b, a)
      if value == colour
        counter += 1
      else
        counter = 0
      end
      return true if counter == 4
    end
    false
  end

  def has_diagonal(colour, x, direction)
    counter = 0
    (0..6).each do |y|
      if grid_value(x + (direction * y), y) == colour
        counter += 1
      else
        counter = 0
      end
      return true if counter == 4
    end
    false
  end

  def grid_value(x, y)
    return nil if x < 0 || x >= 7 || y < 0 || y >= 7
    stack = self.grid[y]
    stack.length > x ? stack[x] : nil
  end

  def apply_move(colour, column)
    self.moves << [colour, column]
    self.grid[0] << colour
  end

  def before_save
    self.moves = self.moves.to_json
    self.grid = self.grid.to_json
  end

  def after_save
    self.moves = JSON.parse(self.moves)
    self.grid = JSON.parse(self.grid)
  end

  def after_find
    self.status = self.status.to_sym
    self.moves = JSON.parse(self.moves)
    self.grid = JSON.parse(self.grid)
  end
end
