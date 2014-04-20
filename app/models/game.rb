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

  def can_join?(user)
  	self.need_player? and !in_game?(user)
  end

  # need to call this before persisting into db
  def self.board_to_fen_board(board)
    flat_board = board.flatten
    fen_board=[]
    board_to_fen_map.each { |k, v|
      fen_board[v-1] = flat_board[k]
    }
    board_string = fen_board.join(",")
  end

  def fen_board_as_array
    board=[0]*64
    fen_board = self.board.split(",").map{|s| s.to_i}
    fen_to_board_map.each { |k, v|
      board[v] = fen_board[k-1]
    }
    board.each_slice(8).to_a
  end

  private
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
end
