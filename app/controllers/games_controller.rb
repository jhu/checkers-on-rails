class GamesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user
  # need to check if it is correct user playing this game
  # before_action :correct_user,   only: :destroy
  # otherwise anyone can see played games

  def index
  	#@games = Game.paginate(page: params[:page], per_page: 15)
  	@waitinggames = Game.where("red_id is null")
  end

  def new
  	#@game = Game.new
  	create
  end

  def show
    @game = Game.find(params[:id])
    @moves = @game.moves
    #@moves = @game.moves
  end
  
  def create
  	# create a game and then wait?
  	@game = Game.new(black:current_user)
  	if @game.save
      flash[:success] = "Game has been created. Waiting for a player."
      redirect_to @game
  	else
  	  redirect_to games_path
  	end
  end

  def destroy
  end

  def update
  	# need to join the waiting game
  	@game = Game.find(params[:id])
  	# need to check if its not full and not already joined
  	if @game.update(red:current_user)
  		flash[:success] = "you have joined this game!"
  		redirect_to @game
  	else
  		render :index
  	end
  end

  private

  	def game_params
  	  params.require(:micropost).permit(:content)
  	end

    def correct_user
      #@game = current_user.games.find_by(id: params[:id])
      #redirect_to root_url if @game.nil?
    end

    def not_yet_join

    end
end
