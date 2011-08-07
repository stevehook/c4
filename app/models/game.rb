class Game < ActiveRecord::Base
  def next_move
    # TODO: This is just a placeholder for now...
    self.moves << ['yellow', 0]
    self.grid[0] << 'yellow'
  end
end
