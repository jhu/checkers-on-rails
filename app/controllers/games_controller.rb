class GamesController < ApplicationController
  include ActionController::Live
  before_action :check_session
  before_action :signed_in_user#,      only: [:index, :show, :join, :rejoin, :play, :myturn, :correct_turn, :correct_player, :update_match_title, :destroy]
  before_action :correct_user,        only: [:index, :show, :update, :destroy]
  before_action :find_game,           only: [:show, :join, :rejoin, :play, :myturn, :correct_turn, :correct_player, :update_match_title]
  before_action :correct_player,      only: [:show, :play, :myturn]
  before_action :correct_turn,        only: :play
  before_action :validate_movetext,   only: :play
  before_action :admin_user,          only: :destroy

  # need to check if it is correct user playing this game
  # otherwise anyone can see played games
  def index
  	# @waitinggames = Game.where("red_id is null or white_id is null")
    # @count = current_user.waiting_and_ongoing_games.count
    @games = Game.paginate(page: params[:page], per_page: 15).where("winner_id is not null").where("white_id is not null").where("red_id is not null")
  end

  def new
  	#create # TODO: this is probably not correct way...
    @game = rand(0..1) == 0 ? Game.new(white:current_user) : Game.new(red:current_user)

    if current_user.waiting_and_ongoing_games.count >= 3
      redirect_to root_path, flash: {error: "You can only be in 3 incompleted games at once!"} 
    elsif @game.save
      @board = @game.fen_board_as_array
      @pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
      redirect_to @game#, flash: {success: "Game has been created. Waiting for a player."}
    else
      redirect_to root_path
    end
  end

  def show
    @moves = @game.moves
    @board = @game.fen_board_as_array
    @turn = @game.get_turn_color current_user
    @pieceImages = {'1'=>'pr.png','2'=>'kr.png','-1'=>'pw.png','-2'=>'kw.png'}
  end

  #def create
  #end

  def destroy
    Game.find(params[:id]).destroy
    flash[:success] = "Game deleted."
    redirect_to games_url
  end

  def update # intentionally join method
  	# need to join the waiting game
  end

  def join
    if @game.in_game?(current_user)
      # already in the game
      redirect_to @game#, flash: {notice: "You are already in this game!"}
    elsif !@game.is_full?
      # what if the game is not full??
      if current_user.waiting_and_ongoing_games.count >= 3
        redirect_to root_path, flash: {error: "You can only be in 3 incompleted games at once!"}
      elsif @game.white.nil? ? @game.update(white:current_user, active:true) # todo: fix this
        : @game.update(red:current_user, active:true) 
        redirect_to @game#, flash: {success: "You have joined this game!"}
      else
        # unable to join
        redirect_to root_path, flash: {error: "You can't join!"}
      end
    else
      redirect_to root_path, flash: {error: "The game is full!"}
    end
  end

  def rejoin
    if !@game.ongoing? and @game.has_winner?
      flash[:notice] = "game completed, view history!"
      redirect_to :show
    else
      # flash[:success] = "rejoined!"
      redirect_to @game
    end
  end

  def play
=begin
    side = params[:turn].to_i
    currentBoard = JSON.parse(params[:board])

    row = params[:row].gsub(/\D/, '')
    column = params[:column].gsub(/\D/, '')

    puts "row,column[ " + row + "," + column + " ]"
    myPlays(currentBoard,side)

    render :json => @plays
=end

    from = @movetext[0]
    to = @movetext[1]
    # turn = params[:turn]
    @boardOld = @game.fen_board_as_array
    # check if the game is over
    if @game.has_winner?
      # need to automatically direct to game results?
      render :json => {valid: false, :message => "The game is over! Go see game page for results."}
    elsif @game.must_jump_beta? from, to
      render :json => {valid: false, :message => "You must make a jump!", :board => @boardOld}
    else
      # # call game model play
      @board = @game.play from, to
      # if nil, set flash to say its invalid move and rerender the game board
      if !@board.nil?
        # @board = @game.fen_board_as_array    
        # flash[:error] = "invalid move or jump!"
        if @game.game_over?(@game.turn)
          @game.update(winner:current_user)
          render :json => {valid: true, :board => @board, :turn => @game.turn,
            :message => "#{@game.winner.name} is declared a winner! Click button below to see game results.", :gameover => true}
        else
          @game.update_next_turn
          render :json => {valid: true, :board => @board, :turn => @game.turn,
            :message => "Valid move/jump!"}
        end
      else
        render :json => {valid: false, :message => "Invalid move/jump!  Try again.", :board => @boardOld}
      end
    end
  end

  def myturn #heartbeat that also blocks if game has not yet started
    if @game.my_turn?(current_user) and @game.ongoing?
      render :json => {:board => @game.fen_board_as_array, :myturn => true}
    elsif @game.ongoing?
      render :json => {:myturn => false}
    elsif @game.has_winner?
      render :json => {:board => @game.fen_board_as_array, :message => "#{@game.winner.name} is declared a winner! Click button below to see game results.", :gameover => true}
    end
  end

  def gameready
    if @game.ongoing?
      render :json => {:ready => true}
    else
      render :json => {:ready => false}
    end
  end

  def update_match_title
    respond_to do |format|
      # format.html
      format.js
    end
    # render :partial => 'matchtitle', :content_type => 'text/html'
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

  # to see what sse is all about...
  def stream
    response.headers['Content-Type'] = 'text/event-stream'

    begin
    loop do
    if (Time.current.sec % 5).zero?
      response.stream.write("event: counter\n")
      response.stream.write("data: 5 seconds passed\n\n")
    end
      sleep 1
    end
    rescue IOError
      # Catch when the client disconnects
    ensure
      response.stream.close
    end
    # render nothing: true
  end

  private
    def find_game
      @game = Game.find(params[:id])
    end

    def validate_movetext
      move_regex = /\A(([1-2][0-9]|[1-9])|3[0-2])(x(([1-2][0-9]|[1-9])|3[0-2]))+\z/
      if !move_regex.match(params[:movetext]).nil? and !defined?(params[:movetext]).nil?
        @movetext = params[:movetext].split('x').map{|s| s.to_i}
      else
        render :json => {valid: false, :message => "Invalid movetext!"} 
      end
    end

    def send_response valid, message, turn, board
      render :json => {
        valid: valid,:message => message,:turn => turn,:board => board
      } 
    end

  	def game_params
  	  params.require(:game).permit(:id)
  	end

    def correct_user
      @user = current_user
      redirect_to(root_url) unless current_user?(@user)
    end

    def correct_turn
      unless @game.my_turn?(current_user)
        # flash.now[:notice] = 'Not your turn yet!'
        # render 'show'
        render :json => {valid: false, :message => "Not your turn!"}
      end
    end

    # TODO: better logic? to check if current player should be in this game
    def correct_player
      if @game.ongoing? and @game.white != current_user and @game.red != current_user
        render :json => {valid: false, :message => "You are not allowed to be in this game!"}
      end
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
=begin
    #### move/jump valdation
    def makeMoves(board,side)
    @plays = Array.new
    if side == 1
      for y in 0..7
        for x in 0..7
          p = board[y][x]
          if p > 0
            move = doMoves(x, y, p,board)
            if move.any?
              @plays.push move;
            end
          end
        end
      end
    elsif side == -1
      7.downto(0) do |y|
        7.downto(0) do |x|
          p = board[y][x];
          if p < 0
            move = doMoves(x, y, p,board)
            if move.any?
              @plays.push move;
            end
          end
        end
      end
    end
    @plays
  end

  def doMoves(x, y, p,board)
    @dirsMap =  {
         1 => [[ 1,  1], [-1,  1]],
         2 => [[ 1,  1], [-1,  1], [ 1, -1], [-1, -1]],
         -1 => [[-1, -1], [ 1, -1]],
         -2 => [[-1, -1], [ 1, -1], [-1,  1], [ 1,  1]]
    }
    plays = Array.new

    dirs = @dirsMap[p]

    dirs.each do |item|
      dir = item
      dx = dir[0]
      dy = dir[1]
      nx = x + dx
      ny = y + dy

      if nx >= 0 && nx < 8 && ny >= 0 && ny < 8
        position = board[y][x]
        n = board[ny][nx]

        if n == 0

          #check promoted
          promoted = (position == 1 && ny == 7) || (position == -1 && ny == 0)
          q = (promoted ? position * 2: position)

          board[y][x]   = 0
          board[ny][nx] = q

          plays.push [x, y, nx, ny]

          board[y][x]   = position
          board[ny][nx] = 0
        end
      end
    end
    plays
  end

  def makeJumps(board,side)
    @jumps = Array.new
    ncurrent = Array.new
    if @side == 1
      for y in 0..8
        for x in 0..8
          p = board[y][x]
          if p > 0
            @jumps = doJumps(x, y, p,[x,y],board,ncurrent,side)
          end
        end
      end
    elsif @side == -1
      7.downto(0) do |y|
        7.downto(0) do |x|
          p = board[y][x];

          if p < 0
            @jumps = doJumps(x, y, p,[x,y],board,ncurrent,side);
          end
        end
      end
    end
    @jumps
  end

  def doJumps (x, y, p,board,ncurrent,side)
    @dirsMap =  {
       1 => [[ 1,  1], [-1,  1]],
       2 => [[ 1,  1], [-1,  1], [ 1, -1], [-1, -1]],
       -1 => [[-1, -1], [ 1, -1]],
       -2 => [[-1, -1], [ 1, -1], [-1,  1], [ 1,  1]]
    }

    @jumps = Array.new

    dirs = @dirsMap[p]
    @oppCount = side == 1 ? 'lcount' : 'dcount'

    dirs.each do |item|
      dir = item
      mx =  x + dir[0]
      nx = mx + dir[0]
      my =  y + dir[1]
      ny = my + dir[1]

      if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8)
        position = board[y][x]
        m = board[my][mx]
        n = board[ny][nx]

        if (n == 0 && ((side ==  1 && m < 0) || (side == -1 && m > 0)))
          promoted = (p == 1 && ny == 7) || (p == -1 && ny == 0);
          ncurrent.push(nx, ny)

          q = (promoted ? p * 2: p)

          if(side == 1)
            board[y][x]   = 0
            board[my][mx] = 0
            board[ny][nx] = q

            if (promoted || !doJumps(nx, ny, p, ncurrent, side))
              @jumps.push ncurrent
              puts "Current jumps being computed" + ncurrent
            end
            board[y][x] = p
            board[my][mx] = m
            board[ny][nx] = 0
          end
        end
      end
    end
    @jumps
  end


  def myPlays(board,side)
    @moves = makeMoves(board,side)
    @jumps = makeJumps(board,side)
    puts "Data for jumps" + @jumps.to_s
    puts "Data for moves" + @moves.to_s
    #makeMoves(board) || makeJumps(board)
  end
=end
end
