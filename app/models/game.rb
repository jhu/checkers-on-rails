class Game < ActiveRecord::Base
  has_one :black, class_name: 'User'
  has_one :red,  class_name: 'User'
end
