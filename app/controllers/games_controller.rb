class GamesController < ApplicationController
  def index

  end

  def new
    create
  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to @game
    else
      redirect_to action: 'index'
    end
  end

  def show
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    @game.attributes = params[:game]
    @game.evaluate_status
    if @game.status == :in_play
      player = Player.new('yellow')
      next_move = player.get_next_move(@game.grid)
      @game.apply_move('yellow', next_move)
      @game.evaluate_status
    end
    @game.save!
    render json: @game
  end
end
