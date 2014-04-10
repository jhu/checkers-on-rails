class User < ActiveRecord::Base
  has_many :black_games, :class_name => 'Game', :foreign_key => 'black_id'
  has_many :red_games, :class_name => 'Game', :foreign_key => 'red_id'

  #has_many :games

  before_save { self.name = name.downcase }
  before_create :create_remember_token
  #VALID_USERNAME_REGEX = /\A([a-zA-Z])\w{2,24}\z/
  #VALID_USERNAME_REGEX = \A[a-zA-Z][a-zA-Z\d]{2,24}\z
  VALID_USERNAME_REGEX = /\A\w\z/
  validates :name, presence: true,
                    #format: { with: VALID_USERNAME_REGEX, 
                     # message: "must be between 3 and 25 characters that must begin with alpha"},
                    uniqueness: { case_sensitive: false }
  #VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  has_secure_password
  VALID_PW_REGEX = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{6,20}\z/
  #validates :password, length: { within: 6..40 }
  validates :password, format: { with: VALID_PW_REGEX, 
  								 message: "must be between 6 and 20 characters that contains at least one of each type of character: lowercase alpha, uppercase alpha, and a numeric value."}
  
  #def getWinCount
  #  Game.count_wins(self)
  #end

  #def getLossCount
  #  Game.count_losses(self)
  #end
  
  def games
    black_games + red_games
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end