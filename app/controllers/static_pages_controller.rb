class StaticPagesController < ApplicationController

  def home
  	if signed_in?
  		@user = current_user
  		@games = @user.completed_games
  		@ongoing_games = @user.ongoing_games
  	end
  end

  def help
  end

  def about
  end

  def contact
  end
end