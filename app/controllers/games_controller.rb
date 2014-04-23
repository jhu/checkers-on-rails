class GamesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:index, :show, :update]
  before_action :correct_turn, only: [:play]
  # need to check if it is correct user playing this game
  # before_action :correct_user,   only: :destroy
  # otherwise anyone can see played games

  def index
  	#@games = Game.paginate(page: params[:page], per_page: 15)
  	@waitinggames = Game.where("red_id is null or black_id is null")
  end

  def new
  	#create # TODO: this is probably not correct way...
    if rand(0..1) == 0
      @game = Game.new(black:current_user)
    else
      @game = Game.new(red:current_user)
    end

    if @game.save
      #flash[:success] = "Game has been created. Waiting for a player."
      redirect_to @game, flash: {success: "Game has been created. Waiting for a player."}
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
      # already in the game
      redirect_to @game, flash: {notice: "You are already in this game!"}
    elsif !@game.is_full?
      # what if the game is not full??
      if @game.black.nil? ? @game.update(black:current_user, active:true) 
        : @game.update(red:current_user, active:true) 
        redirect_to @game, flash: {success: "You have joined this game!"}
      else
        # unable to join
        redirect_to :index, flash: {error: "can't join!"}
      end

=begin
      if @game.black.nil?
        if @game.update(black:current_user, active:true) 
          # join the game
          redirect_to @game, flash: {success: "You have joined this game!"}
        else
          # unable to join
          redirect_to :index, flash: {error: "can't join!"}
        end
      else
        if @game.update(red:current_user, active:true) 
          # join the game
          redirect_to @game, flash: {success: "You have joined this game!"}
        else
          # unable to join
          redirect_to :index, flash: {error: "can't join!"}
        end
      end
=end
    else
      redirect_to :index, flash: {error: "game is full!"}
    end
  end

  def rejoin
    @game = Game.find(params[:id])
    if !@game.ongoing? and @game.has_winner?
      flash[:notice] = "game completed, view history!"
      redirect_to :show
    else
      flash[:success] = "rejoined!"
      redirect_to @game
    end

  end

  def play
    respond_to do |format|
      
    end

    @game = Game.find(params[:id])
    # check if the game is over
    if !@game.winner.nil?
      redirect_to @game, flash: {success: "The game is over!"}
    end

    if @game.must_jump? from, to
      redirect_to @game, flash: {notice: "You need to make a jump!"}
    end

    # call game model play
    @board = @game.play from, to
    # if nil, set flash to say its invalid move and rerender the game board
    if @board.nil?
      @board = @game.fen_board_as_array
      flash[:error] = "invalid move or jump!"
    else
      @game.update_next_turn
      if @game.game_over?(@game.turn)
        return
      end
    end
    redirect_to @game, @board
  end

  private

  	def game_params
  	  params.require(:game).permit(:id)
  	end

    def correct_user
      @user = current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def correct_turn
      #@game = current_user.games.find_by(id: params[:id])
      #redirect_to root_url if @game.nil?
    end

    def not_yet_join
    end
end
