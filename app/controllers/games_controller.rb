class GamesController < ApplicationController
  before_action :signed_in_user

  def index
  end

  def create
  	# create a game and then wait?
  end

  def destroy
  end

  def join
  	# need to join the waiting game
  end

  private

  	def game_params
  		
  	end
end