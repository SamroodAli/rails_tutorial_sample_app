class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    render 'new'
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:passowrd_confirmation)
  end

end
