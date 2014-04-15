class GamesController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :update]
  before_action :correct_user
  # need to check if it is correct user playing this game
  # before_action :correct_user,   only: :destroy
  # otherwise anyone can see played games

  def index
  	#@games = Game.paginate(page: params[:page], per_page: 15)
  	@waitinggames = Game.where("red_id is null")
  end

  def new
  	#create # TODO: this is probably not correct way...
    @game = Game.new(black:current_user)
    if @game.save
      flash[:success] = "Game has been created. Waiting for a player."
      redirect_to @game
    else
      redirect_to games_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @moves = @game.moves
    #@moves = @game.moves
  end

  #def create
  #end

  #def destroy
  #end

  def update # intentionally join method
  	# need to join the waiting game
    @game = Game.find(params[:id])
    if @game.in_game?(current_user)
      flash[:notice] = "You are already in this game!"
      redirect_to @game
    else
      if @game.update(red:current_user, active:true)
        flash[:success] = "You have joined this game!"
        redirect_to @game
      else
        flash[:error] = "can't join!"
        redirect_to :index 
      end
    end
  end

  def rejoin
    # to rejoin?
    @game = Game.find(params[:id])
    if !@game.ongoing? and @game.has_winner?
      flash[:notice] = "game completed, view history!"
      redirect_to :show
    else
      flash[:success] = "rejoined!"
      redirect_to @game
    end

  end

  private

  	def game_params
  	  params.require(:game).permit(:id)
  	end

    def correct_user
      #@game = current_user.games.find_by(id: params[:id])
      #redirect_to root_url if @game.nil?
    end

    def not_yet_join
    end
end
