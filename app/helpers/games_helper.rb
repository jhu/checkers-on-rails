module GamesHelper
  #require_relative 'utils'

  def count(color)
    color == :black ? blacks_count : whites_count
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

    def validate_input(orig, dest)
      case
      when !((1..32).include? orig) || !((1..32).include? dest)
        msg = "numbers must be in the range from 1 to 32"
      when @board[orig].nil?
        msg = "no piece at square #{orig}"
      when @board[orig].color != @turn
        msg = "the piece in square #{orig} is not #{@turn}"
      else
        msg = nil
      end

      msg
    end
end