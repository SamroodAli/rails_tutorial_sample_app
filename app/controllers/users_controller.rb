class UsersController < ApplicationController
  before_action :login_required, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
  end

  def new
    # hello
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
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    if @user&.update(user_params)
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
end
