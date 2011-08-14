describe Player do
  before(:each) do
    @player = Player.new('red')
  end

  context "when game is started" do
    before(:each) do
      @grid = [[], [], [], [], [], [], []]
    end

    it "no columns should be full" do
      (0..6).each { |column| @player.is_column_full(@grid, column).should == false }
    end

    it "no columns should be a winning move" do
      (0..6).each { |column| @player.is_winning_move(@grid, column).should == false }
    end

    it "no columns should be saving move" do
      (0..6).each { |column| @player.is_saving_move(@grid, column).should == false }
    end

    it "should pick column 3" do
      @player.get_next_move(@grid).should == 3
    end
  end

  context "when red has a winning move" do
    before(:each) do
      @grid = [
        ['yellow', 'red'],
        ['red', 'yellow'],
        ['red', 'yellow'],
        ['red', 'yellow'],
        [],
        [],
        []
      ]
    end

    it "no columns should be full" do
      (0..6).each { |column| @player.is_column_full(@grid, column).should == false }
    end

    it "column 4 should be a winning move" do
      @player.is_winning_move(@grid, 4).should == true
    end

    it "no columns should be saving move" do
      (0..6).each { |column| @player.is_saving_move(@grid, column).should == false }
    end

    it "should pick column 4" do
      @player.get_next_move(@grid).should == 4
    end
  end

  context "when yellow has a winning move" do
    before(:each) do
      @grid = [
        ['red', 'yellow'],
        ['yellow', 'red'],
        ['yellow', 'red'],
        ['yellow', 'red'],
        [],
        [],
        []
      ]
    end

    it "no columns should be full" do
      (0..6).each { |column| @player.is_column_full(@grid, column).should == false }
    end

    it "column 4 should be a saving move" do
      @player.is_saving_move(@grid, 4).should == true
    end

    it "no columns should be winning move" do
      (0..6).each { |column| @player.is_winning_move(@grid, column).should == false }
    end

    it "should pick column 4" do
      @player.get_next_move(@grid).should == 4
    end
  end
end

