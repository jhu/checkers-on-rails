class Move < ActiveRecord::Base
  belongs_to :game
  default_scope -> { order('created_at ASC') }
  validates :game_id, presence: true

  def get_turn
  	
  end

  private
  	
end