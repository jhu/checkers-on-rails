class StaticPagesController < ApplicationController
  before_action :static_check_session, only: :home

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

  private
  def static_check_session
    if cookies[:_checkers_app_session].nil?
      sign_out
    end
  end
end