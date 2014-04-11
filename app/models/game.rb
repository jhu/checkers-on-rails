class Game < ActiveRecord::Base
  belongs_to :black, class_name: 'User', :foreign_key => 'black_id'
  belongs_to :red,  class_name: 'User', :foreign_key => 'red_id'

  belongs_to :winner,  class_name: 'User', :foreign_key => 'winner_id'
  default_scope -> { order('created_at DESC') }

  has_many :moves
end
