class Game < ActiveRecord::Base
  after_initialize :init

  def init
    puts 'init'
    self.status = :in_play
  end

  def next_move
    # TODO: This is just a placeholder for now...
    self.moves << ['yellow', 0]
    self.grid[0] << 'yellow'
  end
end
