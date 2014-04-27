class Move < ActiveRecord::Base
  belongs_to :game
  default_scope -> { order('created_at ASC') }
  validates :game_id, presence: true

  def get_turn
    self.turn
  end

  def get_pieces(from)
    red_pieces = get_red_pieces
    white_pieces = get_white_pieces
    return red_pieces if red_pieces.include? from
    return white_pieces if white_pieces.include? from
  end

  private
    def move_params
    end
    
    def get_red_pieces
      # self.fen.split(':')[1][1..-1].split(',')
    end

    def get_white_pieces
      # self.fen.split(':')[2][1..-1].split(',')
    end
end