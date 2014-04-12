class MovesController < ApplicationController
  #before_action :signed_in_user, only: [:create, :destroy]
  #before_action :correct_user,   only: :destroy
  # need to check if it is correct game

  def new
  end

  def show

  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end
