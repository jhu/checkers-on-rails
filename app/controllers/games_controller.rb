class GamesController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user,    only: [:index, :show, :update]
  before_action :correct_player,  only: [:show, :play, :myturn]
  before_action :correct_turn,    only: [:play, :myturn]

  # need to check if it is correct user playing this game
  # before_action :correct_user,   only: :destroy
  # otherwise anyone can see played games

  def index
  	#@games = Game.paginate(page: params[:page], per_page: 15)
  	@waitinggames = Game.where("red_id is null or white_id is null")
    # @count = current_user.waiting_and_ongoing_games.count
  end

  def new
  	#create # TODO: this is probably not correct way...
    @game = rand(0..1) == 0 ? Game.new(white:current_user) : Game.new(red:current_user)

    if current_user.waiting_and_ongoing_games.count >= 3
      redirect_to games_path, flash: {error: "can only be in 3 incompleted games at once!"} 
    elsif @game.save
      @board = @game.fen_board_as_array
      @pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
      redirect_to @game, flash: {success: "Game has been created. Waiting for a player."}
    else
      redirect_to games_path
    end
  end

  def show
    @game = Game.find(params[:id])
    @moves = @game.moves
    @board = @game.fen_board_as_array
    @pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
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
      if current_user.waiting_and_ongoing_games.count >= 3
        redirect_to games_path, flash: {error: "can only be in 3 incompleted games at once!"}
      elsif @game.white.nil? ? @game.update(white:current_user, active:true) 
        : @game.update(red:current_user, active:true) 
        redirect_to @game, flash: {success: "You have joined this game!"}
      else
        # unable to join
        redirect_to games_path, flash: {error: "can't join!"}
      end
    else
      redirect_to games_path, flash: {error: "game is full!"}
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
    # readout = ""
    # params.each{|x|
    #   readout = readout + "#{params[x]} "
    # }

    # for board chedk: \A\[\[\-?[0-2](,-?[0-2]){7}\](,\[\-?[0-2](,-?[0-2]){7}\]){7}\]\z
    # for move check: \A(([1-2][0-9]|[1-9])|3[0-2])(x([1-2]?[0-9]|3[0-2]))+\z
  # render text: "#{params[:movetext]} #{params[:turn]} #{params[:id]}"
    @game = Game.find(params[:id])
    # @game.update(board:Game.board_to_fen_board(params[:boardState]))

    # respond_to do |format|
    #   # format.html { redirect_to @game }
    #   format.json { render :json => @game }

    # validate the move
    logger.debug "checking the movetext #{params[:movetext]}"

    move_regex = /\A(([1-2][0-9]|[1-9])|3[0-2])(x(([1-2][0-9]|[1-9])|3[0-2]))+\z/
    if !move_regex.match(params[:movetext]).nil? and !defined?(params[:movetext]).nil?
      themove = params[:movetext].split('x').map{|s| s.to_i}
    else
      return
    end

    from = themove[0]
    to = themove[1]
    # turn = params[:turn]

    # check if the game is over
    if @game.has_winner?
      # need to automatically direct to game results?
      render :json => {:message => "the game is over!"}
    elsif @game.must_jump? from, to
      render :json => {:message => "you must make a jump!"}
    else
      # # call game model play
      @board = @game.play from, to
      # if nil, set flash to say its invalid move and rerender the game board
      if !@board.nil?
        # @board = @game.fen_board_as_array    
        # flash[:error] = "invalid move or jump!"
        if @game.game_over?(@game.turn)
          render :json => {:message => "we have the winner!"}
        else
          @game.update_next_turn
          render :json => {:board => @board, :turn => @game.turn}
        end
      else
        render :json => {:message => "no move!", :movestring => params[:movetext]}
      end
    end
  end

  def myturn #heartbeat
    @game = Game.find(params[:id])
    if @game.my_turn?(current_user)
      render :json => {:board => @game.fen_board_as_array, :myturn => true}
    else
      render :json => {:myturn => false}
    end
  end

    #redirect_to @game
        # respond_to do |format|
        #   format.html { redirect_to @game }
        # end
        
          # render :json => {:message => "the game is over!"}
          # render :json => {:message => "the game is over!"}
        # @game.update(winner:current_user)
        # redirect_to root_url, flash: {success: "you are the winner!"}
  def handle_unverified_request
    content_mime_type = request.respond_to?(:content_mime_type) ? request.content_mime_type : request.content_type
    if content_mime_type && content_mime_type.verify_request?
      raise ActionController::InvalidAuthenticityToken
    else
      super
      sign_out
      redirect_to root_url
    end
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
      @game = Game.find(params[:id])
      unless @game.my_turn?(current_user)
        # flash.now[:notice] = 'Not your turn yet!'
        # render 'show'
        render :json => {:message => "Not your turn!"}
      end
    end

    # TODO: better logic? to check if current player sould be in this game
    def correct_player
      logger.debug "#{params[:id]}"
      @game = Game.find(params[:id])
      if @game.ongoing? and @game.white != current_user and @game.red != current_user
        render :json => {:message => "you are not allowed to be in this game!"}
      end
    end

    def not_yet_join
    end
end
