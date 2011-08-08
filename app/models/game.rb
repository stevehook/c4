class Game < ActiveRecord::Base
  after_initialize :init
  before_save :before_save
  after_save :after_save

  def init
    self.status = :in_play
    self.moves = []
    self.grid = [[],[],[],[],[],[],[]]
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
    has_horizontal_line(colour)
  end

  def has_horizontal_line(colour)
    (0..6).each do |x|
      return true if has_straight_line(colour, x, true)
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

  def grid_value(x, y)
    return nil if x < 0 || x >= 7 || y < 0 || y >= 7
    stack = self.grid[y]
    stack.length > x ? stack[x] : nil
  end

  def next_move
    # TODO: This is just a placeholder for now...
    self.moves << ['yellow', 0]
    self.grid[0] << 'yellow'
  end

  def before_save
    self.moves = self.moves.to_json
    self.grid = self.grid.to_json
  end

  def after_save
    self.moves = JSON.parse(self.moves)
    self.grid = JSON.parse(self.grid)
  end
end
