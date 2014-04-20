module GamesHelper
  require_relative 'utils'

  def count(color)
    color == :black ? blacks_count : whites_count
  end

  # initial game board state
  def initialize_board
    board = [[ 0,-1,0,-1,0,-1, 0,-1 ],[-1,0,-1,0,-1,0,-1,0],[0,-1,0,-1,0,-1,0,-1],
            [0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0],
            [1,0,1,0,1,0,1,0],[0,1,0,1,0,1,0,1],[1,0,1,0,1,0,1,0]]
    return board
  end

  def must_jump?()
    #TODO: check if the player has to jump
  end

  # player tries to make this play, returns nil if it is not a legal move
  # otherwise returns fen/board of resulted from this move
  def play(game, from, to)
    # TODO: need to make sure from and to are in notaion numbers

    fen = game.moves.last.fen # should be last game state

    # check if there is piece at from
    return nil unless fen.include? from.to_s

    # check if destination is empty
    return nil if fen.include? to.to_s

    #TODO: check if move is forward for this piece
    player_pieces = game.moves.last.get_pieces(from)

    # Move and jump return nil on failure and an instance of PlayResult
    # on success.
    result = move(from, to) || jump(fen, from, to)
  end

  #"B:W18,24,27,28,K10,K15:B12,16,20,K22,K25,K29"
  # this constructs fen string from the board array and current turn
  def to_fen(turn, board)
    # this converts board array into fen
    fen_array = board.flatten
    white_pieces=[]
    black_pieces=[]

    fen_array.each_with_index { |val, index|
      case val
      when 2
        black_pieces<<"K#{board_pos_to_fen_num(index)}"
      when 1
        black_pieces<<"#{board_pos_to_fen_num(index)}"
      when -1
        white_pieces<<"#{board_pos_to_fen_num(index)}"
      when -2
        white_pieces<<"K#{board_pos_to_fen_num(index)}"
      end
    }
    fen = "#{turn}:W#{white_pieces.join(',')}:B#{black_pieces.join(',')}"
  end

  # this constructs board array from fen string
  def to_board(fen)
    fen_array = fen.split(':')
    white_pieces = fen_array[1][1..-1].split(',')
    black_pieces = fen_array[2][1..-1].split(',')
    piece_squares = [0]*32
    white_pieces.each { |piece|
      #fen_piece_to_board_piece(piece_squares, piece)
      if piece.include? 'K'
        piece_squares[piece[1,2].to_i-1] = -2
      else
        piece_squares[piece.to_i-1] = -1
      end
    }
    black_pieces.each { |piece| 
      if piece.include? 'K'
        piece_squares[piece[1,2].to_i-1] = 2
      else
        piece_squares[piece.to_i-1] = 1
      end
    }
    empty_squares = [0]*4
    board = []

    8.times do |row_index|
      row = piece_squares[row_index * 4, 4]
      if row_index.even?
        first = empty_squares
        second = row
      else
        first = row
        second = empty_squares
      end

      row_board = []
      4.times do |col_index|
        row_board << first[col_index]
        row_board << second[col_index]
      end
      board << row_board
    end
    board
  end

  private
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

    possible_jump_map = {
      #1=>[10],2=>[9,11],3=>[],4=>[],5=>[],6=>[],7=>[],8=>[],9=>,
    }

    fen_to_board_map = {
      1=>1,2=>3,3=>5,4=>7,
      5=>8,6=>10,7=>12,8=>14,
      9=>17,10=>19,11=>21,12=>23,
      13=>24,14=>26,15=>28,16=>30,
      17=>33,18=>35,19=>37,20=>39,
      21=>40,22=>42,23=>44,24=>46,
      25=>49,26=>51,27=>53,28=>55,
      29=>56,30=>58,31=>60,32=>62
    }

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

    def init_pieces
    end

    def move(from, to)
      valid_move? from, to
    end

    def jump(from, to)


      jumping = @pieces[from - 1]

      check_for_enemy = jumping.valid_jump_destination? from, to
      return unless check_for_enemy

      target = @pieces[check_for_enemy - 1]
      valid = (!target.nil? && target.color != jumping.color)
      return unless valid

      # Capture enemy piece.
      @pieces[check_for_enemy - 1] = nil

      result = perform_move(from, to)
      result.msg = "captured enemy on #{check_for_enemy}"
      result
    end

    def valid_move?(from, to)
      possible_moves_map[from].include? to
    end
    
    # A jump is valid iff the target square is empty and there's an enemy
    # piece between the origin square and the destination.
    #
    # Returns nil if the destination is not valid for a jump, otherwise returns
    # the square that the board has to check for an enemy piece.
    def valid_jump_destination?(from, to)
      row = Utils.index_to_row(from)
      return if row + 2 != Utils.index_to_row(to)

      case to
      when from + 7
        row.even? ? from + 3 : from + 4
      when from + 9
        row.even? ? from + 4 : from + 5
      else
        nil
      end
    end

    def valid_king_move?(from, to)
    end

    def valid_king_jump_destination?(from, to)
    end

  	def perform_move(from, to)
  	end

    def fen_num_to_board_pos(fen_num)
      fen_to_board_map[fen_num]
    end

    def board_pos_to_fen_num(board_pos)
      board_to_fen_map[board_pos]
    end

    def fen_piece_to_board_piece(color, fen_piece)
      #if fen_piece.include? 'K' board_piece = 2 else board_piece = 1 end
    end

    def legal_move?(move)
    	@prevMove = self.moves.order("created_at").last
    	get_turn(@prevMove.fen)
    	  	#self.moves.last # previous move that has been saved into
    end
end