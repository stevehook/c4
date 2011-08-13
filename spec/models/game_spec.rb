require 'spec_helper'

describe Game do
  context "when a new game is created" do
    before(:each) do
      @game = Game.new
    end

    it "should have status :in_play" do
      @game.status.should == :in_play
    end

    it "should have empty grid array" do
      @game.grid.should == [[], [], [], [], [], [], []]
    end

    it "should have empty moves array" do
      @game.moves.should == []
    end
  end

  context "when a game is read" do
    before(:each) do
      game = Game.new()
      game.moves = [['red', 3], ['yellow', 3], ['red', 1], ['yellow', 1], ['red', 2]]
      game.grid = [[], ['red', 'yellow'], ['red'], ['red', 'yellow'], [], [], []]
      game.save
      @game = Game.find(game.id)
    end

    it "should have status :in_play" do
      @game.status.should == :in_play
    end

    it "should have pre-initialised grid array" do
      @game.grid.should == [[], ['red', 'yellow'], ['red'], ['red', 'yellow'], [], [], []]
    end

    it "should have pre-initialised moves array" do
      @game.moves.should == [['red', 3], ['yellow', 3], ['red', 1], ['yellow', 1], ['red', 2]]
    end
  end

  context "After red has three in a row horizontally" do
    before( :each ) do
      @game = Game.new
      @game.moves = [['red', 3], ['yellow', 3], ['red', 1], ['yellow', 1], ['red', 2]]
      @game.grid = [[], ['red', 'yellow'], ['red'], ['red', 'yellow'], [], [], []]
    end

    it "should have a winner" do
      @game.evaluate_status
      @game.winner.should be_nil
    end

    it "should be finished" do
      @game.evaluate_status
      @game.status.should == :in_play
    end
  end  

  context "After red has four in a row horizontally" do
    before( :each ) do
      @game = Game.new
      @game.moves = [['red', 3], ['yellow', 3], ['red', 1], ['yellow', 1], ['red', 2], ['yellow', 2], ['red', 4]]
      @game.grid = [[], ['red', 'yellow'], ['red', 'yellow'], ['red', 'yellow'], ['red'], [], []]
    end

    it "should have a winner" do
      @game.evaluate_status
      @game.winner.should == 'red'
    end

    it "should be finished" do
      @game.evaluate_status
      @game.status.should == :finished
    end
  end  

  context "After red has four in a row vertically" do
    before( :each ) do
      @game = Game.new
      @game.moves = [['red', 3], ['yellow', 2], ['red', 3], ['yellow', 2], ['red', 3], ['yellow', 2], ['red', 3]]
      @game.grid = [[], [], ['yellow', 'yellow', 'yellow'], ['red', 'red', 'red', 'red'], [], [], []]
    end

    it "should have a winner" do
      @game.evaluate_status
      @game.winner.should == 'red'
    end

    it "should be finished" do
      @game.evaluate_status
      @game.status.should == :finished
    end
  end  

  context "After red has four in a row diagonally (bottom-left to top-right)" do
    before( :each ) do
      @game = Game.new
      @game.moves = [['red', 1], ['yellow', 2], ['red', 2], ['yellow', 3], ['red', 3], ['yellow', 2], ['red', 3], 
        ['yellow', 4], ['red', 4], ['yellow', 4], ['red', 4]]
      @game.grid = [[], ['red'], ['yellow', 'red', 'yellow'], ['yellow', 'red', 'red'], ['yellow', 'red', 'yellow', 'red'], [], []]
    end

    it "should have a winner" do
      @game.evaluate_status
      @game.winner.should == 'red'
    end

    it "should be finished" do
      @game.evaluate_status
      @game.status.should == :finished
    end
  end  

  context "After red has four in a row diagonally (top-left to bottom-right)" do
    before( :each ) do
      @game = Game.new
      @game.moves = [['red', 4], ['yellow', 3], ['red', 3], ['yellow', 2], ['red', 2], ['yellow', 3], ['red', 2], 
        ['yellow', 1], ['red', 1], ['yellow', 1], ['red', 1]]
      @game.grid = [[], ['yellow', 'red', 'yellow', 'red'], ['yellow', 'red', 'red'], ['yellow', 'red', 'yellow'], ['red'], [], []]
    end

    it "should have a winner" do
      @game.evaluate_status
      @game.winner.should == 'red'
    end

    it "should be finished" do
      @game.evaluate_status
      @game.status.should == :finished
    end
  end  
end

