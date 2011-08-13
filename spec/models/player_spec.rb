describe Player do
  before(:each) do
    @player = Player.new(:red)
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
end

