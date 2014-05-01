class StaticPagesController < ApplicationController

  def home
  	if signed_in?
  		@user = current_user
  		# @games = @user.completed_games
      @games = Game.find(:all, :conditions => {:active => false, :winner_id => nil})
  		@waiting_ongoing_games = @user.waiting_and_ongoing_games
  	end
  end

  def help
  end

  def about
  end

  def contact
  end
end