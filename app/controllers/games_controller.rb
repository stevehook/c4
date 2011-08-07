class GamesController < ApplicationController
  def index

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
    
  end

  def update
    @game = Game.find(params[:id])
    @game.attributes = params[:game]
    @game.next_move
    @game.save!
    # logger.info @game.grid.class
    # logger.info @game.grid
    # logger.info @game.moves.class
    # logger.info @game.moves
    # TODO: make the next move
    render json: @game
  end
end
