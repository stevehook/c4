class Game < ActiveRecord::Base
  after_initialize :init
  before_save :before_save
  after_save :after_save

  def init
    self.status = :in_play
    self.moves = []
    self.grid = [[],[],[],[],[],[],[]]
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
