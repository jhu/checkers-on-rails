class Game < ActiveRecord::Base
  belongs_to :black, class_name: 'User', :foreign_key => 'black_id'
  belongs_to :red,  class_name: 'User', :foreign_key => 'red_id'
  belongs_to :winner,  class_name: 'User', :foreign_key => 'winner_id'
  has_many :moves
  default_scope -> { order('created_at DESC') }
  # 1-0 black won, 0-1 white won, * in progress
  validates_inclusion_of :result, :in => %w( 1-0 0-1 *)

  # checks if game is ongoing
  def ongoing?
  	self.active and self.result.eql? '*'
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
end
