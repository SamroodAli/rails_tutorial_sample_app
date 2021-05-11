class UsersController < ApplicationController
  before_action :login_required, only: %i[index edit update destroy]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user , only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Profile updated'
      redirect_to @user
    else
      flash[:danger] = 'Please provide valid entries'
      render :edit
    end
  end


  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_required
    unless logged_in?
      store_original_url
      flash[:danger] = 'PLease log in'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to login_url unless correct_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
