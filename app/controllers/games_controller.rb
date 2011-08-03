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
end
