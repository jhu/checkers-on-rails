class GamesController < ApplicationController
  before_action :signed_in_user

  def index
  	#@games = Game.paginate(page: params[:page], per_page: 15)
  	@waitinggames = Game.where("red_id is null")
  end

  def new
  end

  def show
    @game = Game.find(params[:id])
    #@moves = @game.moves
  end
  
  def create
  	# create a game and then wait?
  end

  def destroy
  end

  def join
  	# need to join the waiting game
  end

  private

  	def game_params
  		
  	end
end
