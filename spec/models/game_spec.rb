require 'spec_helper'

describe Game do
  context "when a new game is created" do
    @game = Game.new

    it "should have status :in_play" do
      @game.status.should == :in_play
    end
  end
end
