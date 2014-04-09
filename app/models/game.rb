class Game < ActiveRecord::Base
  has_many :matches
  has_many :users, through: matches
  has_one :black, class_name: 'User', through: :match, order: 'score DESC'
  has_one :red,  class_name: 'User', through: :match, order: 'score ASC'
end