class SessionsController < ApplicationController
  rescue_from ActionController::InvalidAuthenticityToken, :with => :go_to_root

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      # redirect_back_or user
      redirect_to root_url
    else
      flash.now[:error] = 'Invalid name/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def go_to_root
    redirect_to root_url
  end
end