class User < ActiveRecord::Base
  has_many :white_games, :class_name => 'Game', :foreign_key => 'white_id'
  has_many :red_games, :class_name => 'Game', :foreign_key => 'red_id'
  has_many :winner_games, :class_name => 'Game', :foreign_key => 'winner_id'
  #has_many :games

  before_save { self.name = name.downcase }
  before_create :create_remember_token
  #VALID_USERNAME_REGEX = /\A([a-zA-Z])\w{2,24}\z/
  VALID_USERNAME_REGEX = /\A[a-zA-Z][a-zA-Z\d]{5,24}\z/
  #validates_format_of :name, with: ->(user) { user.admin? ? /\A[a-z0-9][a-z0-9_\-]*\z/i : /\A[a-z][a-z0-9_\-]*\z/i }

  validates :name, presence: true,
                    format: { with: VALID_USERNAME_REGEX, 
                    message: "must be between 6 and 25 characters that contains alphanumeric and must begin with alphabetic"},
                    uniqueness: { case_sensitive: false }

  has_secure_password
  VALID_PW_REGEX = /\A(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9]).{8,20}\z/
  #validates :password, length: { within: 6..40 }
  validates :password, format: { with: VALID_PW_REGEX, message: "must be between 8 and 20 characters and include at least one lowercase letter, one uppercase letter, and one digit"}

  def win_count
    self.winner_games.count
    #Game.where("winner_id = ? and result is not '*'", self.id).count
  end
  
  def loss_count
    self.completed_games.count - self.win_count
    #self.games.count - self.win_count
  end

  def games
    white_games + red_games
  end

  def completed_games
    white_games.where("winner_id is not null") + red_games.where("winner_id is not null")
  end

  def ongoing_games
    white_games.where("winner_id is null").where(active: true) + red_games.where("winner_id is null").where(active: true)
  end

  def waiting_games
    white_games.where("winner_id is null").where(active: false) + red_games.where("winner_id is null").where(active: false)
  end

  def waiting_and_ongoing_games
    white_games.where("winner_id is null") + red_games.where("winner_id is null")
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
