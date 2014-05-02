class Game < ActiveRecord::Base
  belongs_to :white, class_name: 'User', :foreign_key => 'white_id'
  belongs_to :red,  class_name: 'User', :foreign_key => 'red_id'
  belongs_to :winner,  class_name: 'User', :foreign_key => 'winner_id'
  has_many :moves, dependent: :destroy
  default_scope -> { order('created_at DESC') }

  def get_turn_color user
    if self.red.eql? user
      return 'red'
    elsif self.white.eql? user
      return 'white'
    else
      return 'nocolor'
    end
  end
  # checks if game is ongoing
  def ongoing?
  	self.active and self.winner.nil?
  end

  def waiting?
  	!self.active and self.winner.nil?
  end

  def need_player?
  	self.white.nil? or self.red.nil?
  end

  def is_full?
  	!self.white.nil? and !self.red.nil?
  end

  def has_winner?
  	!self.winner.nil?
  end

  def in_game?(user)
  	self.white.eql? user or self.red.eql? user
  end

  def my_turn?(user)
    self.turn == "red" ? self.red == user : self.white == user
  end

  def update_next_turn
    turn = self.turn == "white" ? "red" : "white"
    self.update(turn: turn)
  end

  # need to call this before persisting into db
  # this will convert view based board array into string representation 
  # of board with fen coordinates before saving it into Game model
  # i.e. 
  def self.board_to_fen_board(board)
    map = get_board_to_fen_map
    flat_board = board.flatten
    fen_board=[]
    map.each { |k, v|
      fen_board[v-1] = flat_board[k]
    }
    board_string = fen_board.join(",")
  end

  # this will convert string representation of board (in fen) into
  # array for view board 
  def fen_board_as_array
    map = get_board_to_fen_map
    board=[0]*64
    fen_board = self.board.split(",").map{|s| s.to_i}
    map.each { |k, v|
      board[k] = fen_board[v-1]
    }
    board.each_slice(8).to_a
  end

  # initial game board state (needed?)
  def initialize_board
    init_board = "-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1"
    if self.update(board: init_board)
      return [[ 0,-1,0,-1,0,-1, 0,-1 ],[-1,0,-1,0,-1,0,-1,0],[0,-1,0,-1,0,-1,0,-1],
            [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],
            [1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
      end
  end

  # player tries to make this play, returns nil if it is not a legal move
  # otherwise returns fen/board of resulted from this move
  # from/to has to be in notation number (fen)
  def play(from, to)

    pieces = self.board.split(",").map{|s| s.to_i}

    # correct turn?
    return nil unless self.turn == Game.get_color(pieces[from - 1])
     
    # check if there is piece at from
    return nil if pieces[from - 1] == 0
    # check if destination is empty
    return nil unless pieces[to - 1] == 0

    # Move and jump return nil on failure and array of board 
    # resulted from the move
    result = move(from, to) || jump(from, to)
  end

  def game_over?(turn)
    count_pieces(turn) == 0
  end

  # checks if piece is king
  def self.is_king?(piece)
    piece == 2 or piece == -2
  end

  def self.get_color(piece)
    return if piece == 0
    return "red" if piece > 0
    return "white" if piece < 0
  end

  def self.is_red?(piece)
    piece > 0
  end

  def self.is_white?(piece)
    piece < 0
  end

  def self.at_kingrow?(piece, pos)
    logger.debug "is it at kingrow piece #{piece} pos: #{pos}"
    if Game.is_red? piece
      logger.debug "it is red piece at kingrow?"
      return Game.index_to_row(pos) == 7
    elsif Game.is_white? piece
      logger.debug "it is white piece at kingrow? #{Game.index_to_row(pos)}"

      return Game.index_to_row(pos) == 0
    end
  end

  # changes piece to king
  def self.kinged(piece)
    return piece > 0 ? 2 : -2
  end

  def must_jump?(from, to)
    pieces = self.board.split(",").map{|s| s.to_i}
    my_color = Game.get_color pieces[from - 1]

    # making sure that the proposed move is actual jump
    target = valid_jump_destination?(from, to, pieces)
    if my_color.eql? 'red' and !target.nil?
      return false if Game.get_color(pieces[target - 1]).eql? 'white'
    elsif my_color.eql? 'white' and !target.nil?
      return false if Game.get_color(pieces[target - 1]).eql? 'red'
    end

    # must loop through for first potential move and return true
    logger.debug "this from is color #{my_color}"
    pieces.each_with_index do |piece, coord|
      logger.debug "loop: #{coord+1} #{piece}"
      piece_color = Game.get_color piece
      logger.debug "possible from color #{piece_color}"
      if my_color.eql? piece_color and my_color.eql? 'red'
        return true if red_must_jump?(coord+1, pieces)
      elsif !piece_color.nil? and my_color.eql? piece_color and my_color.eql? 'white'
        return true if white_must_jump?(coord+1, pieces)
      end
    end
    return false
  end

  private
    def possible_jump_destinations from
      possible_jumps_map = {
        1=>[10],2=>[9,11],3=>[10,12],4=>[11],
        5=>[14],6=>[13,15],7=>[14,16],8=>[15],
        9=>[2,18],10=>[1,3,17,19],11=>[2,4,18,20],12=>[3,19],
        13=>[6,22],14=>[5,7,21,23],15=>[6,8,22,24],16=>[7,23],
        17=>[10,26],18=>[9,11,25,27],19=>[10,12,26,28],20=>[11,27],
        21=>[14,30],22=>[13,15,29,31],23=>[14,16,30,32],24=>[15,31],
        25=>[18],26=>[17,19],27=>[18,20],28=>[19],
        29=>[22],30=>[21,23],31=>[22,24],32=>[23]
      }
      return possible_jumps_map[from]
    end 

    def possible_downward_jump_dests from
      possible_jumps_map = {
          1=>[10],2=>[9,11],3=>[10,12],4=>[11],
          5=>[14],6=>[13,15],7=>[14,16],8=>[15],
          9=>[18],10=>[17,19],11=>[18,20],12=>[19],
          13=>[22],14=>[21,23],15=>[22,24],16=>[23],
          17=>[26],18=>[25,27],19=>[26,28],20=>[27],
          21=>[30],22=>[29,31],23=>[30,32],24=>[31]
        }
      return possible_jumps_map[from]
    end
    
    
    def possible_upward_jump_dests from
      possible_jumps_map = {
          9=>[2],10=>[1,3],11=>[2,4],12=>[3],
          13=>[6],14=>[5,7],15=>[6,8],16=>[7],
          17=>[10],18=>[9,11],19=>[10,12],20=>[11],
          21=>[14],22=>[13,15],23=>[14,16],24=>[15],
          25=>[18],26=>[17,19],27=>[18,20],28=>[19],
          29=>[22],30=>[21,23],31=>[22,24],32=>[23]
      }
      return possible_jumps_map[from]
    end

    def get_board_to_fen_map
      return board_to_fen_map = {
        1=>1,3=>2,5=>3,7=>4,
        8=>5,10=>6,12=>7,14=>8,
        17=>9,19=>10,21=>11,23=>12,
        24=>13,26=>14,28=>15,30=>16,
        33=>17,35=>18,37=>19,39=>20,
        40=>21,42=>22,44=>23,46=>24,
        49=>25,51=>26,53=>27,55=>28,
        56=>29,58=>30,60=>31,62=>32
      }
    end

    def get_possible_moves_map
      return possible_moves_map = {
        1=>[5,6],2=>[6,7],3=>[7,8],4=>[8],
        5=>[1,9],6=>[1,2,9,10],7=>[2,3,10,11],8=>[3,4,11,12],
        9=>[5,6,13,14],10=>[6,7,14,15],11=>[7,8,15,16],12=>[8,16],
        13=>[9,17],14=>[9,10,17,18],15=>[10,11,18,19],16=>[11,12,19,20],
        17=>[13,14,21,22],18=>[14,15,22,23],19=>[15,16,23,24],20=>[16,24],
        21=>[17,25],22=>[17,18,25,26],23=>[18,19,26,27],24=>[19,20,27,28],
        25=>[21,22,29,30],26=>[22,23,30,31],27=>[23,24,31,32],28=>[24,32],
        29=>[25],30=>[25,26],31=>[26,27],32=>[27,28]
      }
    end

    def move(from, to)
      pieces = self.board.split(",").map{|s| s.to_i}
=begin
      if Game.is_king?(from)
        return unless valid_king_move? from, to
      else
        return unless valid_move? from, to
      end
=end
      # maybe check if its required to jump?
      return unless valid_move? from, to, pieces
      perform_move(from, to, pieces)
    end

    def jump(from, to)
      logger.debug "#{from} #{to}"
      pieces = self.board.split(",").map{|s| s.to_i}
      jumping = pieces[from - 1]

      check_for_enemy = valid_jump_destination? from, to, pieces
      logger.debug "enemy: #{check_for_enemy}"
      return if check_for_enemy.nil?

      target = pieces[check_for_enemy - 1]
      logger.debug "target is at #{check_for_enemy - 1} and its #{target}"
      valid = target != 0 && Game.get_color(target) != Game.get_color(jumping)
      logger.debug "target is nil? #{target.nil?}"
      logger.debug "target color: #{Game.get_color(target)}"
      logger.debug "jumping color: #{Game.get_color(jumping)}"

      logger.debug "enemy: #{valid}"
      return unless valid

      # Capture enemy piece.
      pieces[check_for_enemy - 1] = 0

      perform_move(from, to, pieces)
    end

    def perform_move(from, to, pieces)
      # move and jump invoke this method only when it's certain that the move
      # is valid.
      # result = PlayResult.new(success: true)
      moving = pieces[from - 1]
      pieces[from - 1] = 0

      if Game.at_kingrow? moving, to
        logger.debug "yes"
        pieces[to - 1] = Game.kinged moving
      else
        pieces[to - 1] = moving
      end
      board = pieces.join(",")
      if self.update(board: board)
        movetext = Game.get_movetext(from, to)
        if self.turn.eql? 'red'
          turn = self.red.name
        else
          turn = self.white.name
        end
        self.moves.create({movetext: movetext, board: board, turn: turn}) 
        return fen_board_as_array
      end
      return
    end

    def self.get_movetext(from, to)
      return "#{from}x#{to}"
    end

    # return false if the move is not valid 
    # i.e. not forward move or destination is incorrect
    def valid_move?(from, to, pieces)
      logger.debug "checking to see if its a valid move"
      # check if move is forward for plain piece (not king)
      row = Game.index_to_row(from)
      logger.debug "from #{pieces[from]}"
      logger.debug "to #{pieces[to]}"
      if Game.is_king?(pieces[from-1]) # kings can go in both direction
        return false if (row + 1 != Game.index_to_row(to)) and (row - 1 != Game.index_to_row(to)) 
      elsif Game.is_red?(pieces[from-1])
        logger.debug "its red!"
        logger.debug "from row#{Game.index_to_row(from)}"
        logger.debug "to row#{Game.index_to_row(to)}"
        return false if row + 1 != Game.index_to_row(to)
      elsif Game.is_white?(pieces[from-1]) and !Game.is_king?(pieces[from-1]) # kings can go in both direction
        logger.debug "its white!"
        return false if row - 1 != Game.index_to_row(to)
      end
      map = get_possible_moves_map
      logger.debug "in map? #{map[from].include? to}"
      map[from].include? to
    end
    
    # A jump is valid iff the target square is empty and there's an enemy
    # piece between the origin square and the destination.
    #
    # Returns nil if the destination is not valid for a jump, otherwise returns
    # the square that the board has to check for an enemy piece.
    def valid_jump_destination?(from, to, pieces)
      logger.debug "checking to see if its valid jump - from: #{from} to: #{to}"
      row = Game.index_to_row(from)
      target = nil
      if Game.is_king?(pieces[from-1])
        return if (row + 2 != Game.index_to_row(to)) and (row - 2 != Game.index_to_row(to))
        target = get_target_for_red(row, from, to) || get_target_for_white(row, from, to)
      elsif Game.is_red?(pieces[from-1])
        return if row + 2 != Game.index_to_row(to)
        target = get_target_for_red(row, from, to)
      elsif Game.is_white?(pieces[from-1])
        return if row - 2 != Game.index_to_row(to)
        target = get_target_for_white(row, from, to)
      end
      return target
    end

    def get_target_for_red(row, from, to)
      case to
      when from + 7
        logger.debug "from + 7"
        target = row.even? ? from + 4 : from + 3
      when from + 9
        logger.debug "from + 9"
        target = row.even? ? from + 5 : from + 4
      else
        target = nil
      end
      return target
    end
    def get_target_for_white(row, from, to)
      case to
      when from - 7
        target = row.even? ? from - 3 : from - 4
      when from - 9
        target = row.even? ? from - 4 : from - 5
      else
        target = nil
      end
      return target
    end

    # this will determine if player has pieces left to end the game
    def count_pieces(color)
      color == "red" ? whites_count : reds_count
    end

    def whites_count
      pieces = self.board.split(",").map{|s| s.to_i}
      pieces.count { |p| p != 0 && Game.get_color(p) == "white"}
      #@pieces.count { |p| !p.nil? && p.color == :white }
    end

    def reds_count
      pieces = self.board.split(",").map{|s| s.to_i}
      pieces.count { |p| p != 0 && Game.get_color(p) == "red"}
      #@pieces.count { |p| !p.nil? && p.color == :red }
    end

  def self.index_to_row(piece_index)
    row_index = (piece_index - 1) / 4
  end
  


  def red_must_jump?(from, pieces)
    possible_dest = possible_downward_jump_dests from
    possible_dest = [] if possible_dest.nil?
    if pieces[from - 1].eql? 2 and !possible_upward_jump_dests(from).nil?# king
      possible_dest = (possible_dest + possible_upward_jump_dests(from)).uniq
    end
    possible_dest.each do |to,i|
      target = valid_jump_destination?(from, to, pieces)
      if !target.nil? and Game.get_color(pieces[target - 1]).eql? 'white' and pieces[to - 1].eql? 0
        return true
      end
    end
    return false
  end

  def white_must_jump?(from, pieces)
    possible_dest = possible_upward_jump_dests from
    possible_dest = [] if possible_dest.nil?
    if pieces[from - 1].eql? -2 and !possible_downward_jump_dests(from).nil?# king
      possible_dest = (possible_dest + possible_downward_jump_dests(from)).uniq
    end
    possible_dest.each do |to,i|
      target = valid_jump_destination?(from, to, pieces)
      # must make sure target piece is oppsoite color and to is empty
      if !target.nil? and (Game.get_color(pieces[target - 1]).eql? 'red') and (pieces[to - 1] == 0)
        return true
      end
    end
    return false
  end
end
