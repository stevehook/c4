require 'spec_helper'

describe Game do
  context "when a new game is created" do
    before(:each) do
      @game = Game.new
    end

    it "should have status :in_play" do
      @game.status.should == :in_play
    end
  end
end
