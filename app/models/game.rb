class Game < ActiveRecord::Base
  has_many :matches
  #has_many :users, through: matches
  has_one :black, class_name: 'User', through: :matches, :source => :match
  has_one :red,  class_name: 'User', through: :matches, :source => :match
  #has_one :black, :through :matches, :source => :user
  
  def self.count_wins(user)
  	games = user.games
  	won_matches.count
  end

  def self.count_losses(user)
  	won_matches.count
  end
end