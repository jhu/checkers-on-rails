class Game < ActiveRecord::Base
  belongs_to :black, class_name: 'User', :foreign_key => 'black_id'
  belongs_to :red,  class_name: 'User', :foreign_key => 'red_id'
  belongs_to :winner,  class_name: 'User', :foreign_key => 'winner_id'
  has_many :moves
  default_scope -> { order('created_at DESC') }

  # checks if game is ongoing
  def ongoing?
  	self.active and self.winner.nil?
  end

  def waiting?
  	!self.active and self.winner.nil?
  end

  def need_player?
  	self.black.nil? or self.red.nil?
  end

  def is_full?
  	!self.black.nil? and !self.red.nil?
  end

  def has_winner?
  	!self.winner.nil?
  end

  def in_game?(user)
  	user == self.black or user == self.red
  end

  #def can_join?(user)
  #	self.need_player? and !in_game?(user)
  #end

  def update_next_turn
    turn = self.turn == "black" ? "red" : "black"
    self.update(turn: turn)
  end

  # need to call this before persisting into db
  # this will convert view based board array into string representation 
  # of board with fen coordinates before saving it into Game model
  # i.e. 
  def self.board_to_fen_board(board)
    flat_board = board.flatten
    fen_board=[]
    board_to_fen_map.each { |k, v|
      fen_board[v-1] = flat_board[k]
    }
    board_string = fen_board.join(",")
  end

  # this will convert string representation of board (in fen) into
  # array for view board 
  def fen_board_as_array
    board=[0]*64
    fen_board = self.board.split(",").map{|s| s.to_i}
    board_to_fen_map.each { |k, v|
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

  def must_jump?(from)
    #TODO: check if the player has to jump
    self.board
  end

  def self.is_king?(piece)
    piece == 2 or piece == -2
  end

  def self.get_color(piece)
    piece > 0 ? "black" : "white"
  end

  def self.is_black?(piece)
    piece > 0
  end

  def self.to_be_king?(piece, pos)
    if Game.is_black? piece
      return Utils.index_to_row(pos) == 7
    else
      return Utils.index_to_row(pos) == 0
    end
  end

  def self.kinged(piece)
    return piece > 0 ? 2 : -2
  end

  private
    # mapping from 
    board_to_fen_map = {
      1=>1,3=>2,5=>3,7=>4,
      8=>5,10=>6,12=>7,14=>8,
      17=>9,19=>10,21=>11,23=>12,
      24=>13,26=>14,28=>15,30=>16,
      33=>17,35=>18,37=>19,39=>20,
      40=>21,42=>22,44=>23,46=>24,
      49=>25,51=>26,53=>27,55=>28,
      56=>29,58=>30,60=>31,62=>32
    }

    possible_moves_map = {
      1 => [5, 6], 2 => [6, 7], 3 => [7, 8], 4 => [8],
      5 => [1, 9], 6 => [1, 2, 9, 10], 7 => [2, 3, 10, 11], 8 => [3, 4, 11, 12],
      9 => [5, 6, 13, 14], 10 => [6, 7, 14, 15], 11 => [7, 8, 15, 16], 12 => [8, 16],
      13 => [9, 17], 14 => [9, 10, 17, 18], 15 => [10, 11, 18, 19], 16 => [11, 12, 19, 20],
      17 => [13, 14, 21, 22], 18 => [14, 15, 22, 23], 19 => [15, 16, 23, 24], 20 => [16, 24],
      21 => [17, 25], 22 => [17, 18, 25, 26], 23 => [18, 19, 26, 27], 24 => [19, 20, 27, 28],
      25 => [21, 22, 29, 30], 26 => [22, 23, 30, 31], 27 => [23, 24, 31, 32], 28 => [24, 32],
      29 => [25], 30 => [25, 26], 31 => [26, 27], 32 => [27, 28]
    }


    def init_pieces
    end

    def move(from, to)
      pieces = self.board.split(",").map{|s| s.to_i}
      return unless valid_move? from, to
      perform_move(from, to, pieces)
    end

    def jump(from, to)
      pieces = self.board.split(",").map{|s| s.to_i}
      jumping = pieces[from - 1]

      check_for_enemy = jumping.valid_jump_destination? from, to
      return if check_for_enemy.nil?

      target = pieces[check_for_enemy - 1]
      valid = !target.nil? && Game.get_color(target) != Game.get_color(jumping)
      return unless valid

      # Capture enemy piece.
      pieces[check_for_enemy - 1] = 0

      perform_jump(from, to, pieces)
    end

    def perform_move(from, to, pieces)
      # move and jump invoke this method only when it's certain that the move
      # is valid.
      # result = PlayResult.new(success: true)
      moving = pieces[from - 1]
      pieces[from - 1] = 0

      if Game.to_be_king? to
        pieces[to - 1] = Game.kinged moving
      else
        pieces[to - 1] = moving
      end
      board = pieces.join(",")
      if self.update(board: board)
        movetext = Game.get_movetext(from, to)
        fen = Game.standard_notation(pieces, from)

        # TODO create move and save
        self.moves.create({movetext: movetext, fen: fen, startpos: from, endpos: to})
        
        return fen_board_as_array board
      end
      
    end

    # return false if the move is not valid 
    # i.e. not forward move or destination is incorrect
    def valid_move?(from, to)
      # check if move is forward for plain piece (not king)
      row = Utils.index_to_row(from)
      if Game.is_black?(from)
        return false if row + 1 != Utils.index_to_row(to)
      else
        return false if row - 1 != Utils.index_to_row(to)
      end
      possible_moves_map[from].include? to
    end
    
    # A jump is valid iff the target square is empty and there's an enemy
    # piece between the origin square and the destination.
    #
    # Returns nil if the destination is not valid for a jump, otherwise returns
    # the square that the board has to check for an enemy piece.
    def valid_jump_destination?(from, to)
      row = Utils.index_to_row(from)
      target = nil
      if Game.is_black?(from)
        return if row + 2 != Utils.index_to_row(to)

        case to
        when from + 7
          target = row.even? ? from + 3 : from + 4
        when from + 9
          target = row.even? ? from + 4 : from + 5
        else
          target = nil
        end
      else
        return if row - 2 != Utils.index_to_row(to)

        case to
        when from - 7
          target = row.even? ? from - 4 : from - 3
        when from - 9
          target = row.even? ? from - 5 : from - 4
        else
          target = nil
        end
      end
      return target
    end

    def valid_king_move?(from, to)
    end

    def valid_king_jump_destination?(from, to)
    end

    # this will determine if player has pieces left to end the game
    def count(color)
      color == :black ? blacks_count : whites_count
    end

    def whites_count
      @pieces.count { |p| !p.nil? && p.color == :white }
    end

    def blacks_count
      @pieces.count { |p| !p.nil? && p.color == :black }
    end
end
