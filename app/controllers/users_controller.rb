class UsersController < ApplicationController
  before_action :login_required, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save
      log_in @user
      flash[:success] = 'Welcome to the Sample App'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      flash[:danger] = 'Please provide valid entries'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_required
    unless logged_in?
      flash[:danger] = 'PLease log in'
      redirect_to login_url
    end
  end

  def correct_user
    @user =  User.find_by(id: params[:id])
    flash[:danger] = "Wrong user, please sign in to your account"
    redirect_to login_url unless @user == current_user
  end
end
