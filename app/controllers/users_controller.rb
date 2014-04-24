class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 15).where(admin:false)
  end

  def show
    @user = User.find(params[:id])
    @games = @user.completed_games
    #if current_user?(@user)
    @waiting_ongoing_games = @user.waiting_and_ongoing_games
    #end
    #@games = @user.games # TODO: need to figure out how to get completed games
    #@games = @user.games.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    #@user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Checkers App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end

    # Before filters
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end