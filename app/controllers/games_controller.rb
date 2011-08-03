class GamesController < ApplicationController
  def index

  end

  def create
    @game = Game.new(params[:game])

    if @game.save
      redirect_to(@game, :notice => 'Game was successfully created.')
    else
      redirect_to root_path
    end
  end

  def show
    
  end
end
