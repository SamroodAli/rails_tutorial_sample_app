class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid? && @user.save
      render 'new'
    else
      render 'new'
    end
    
  end

  private
  
  def user_params
    params.require(:user).permit(:name,:email,:password,:passowrd_confirmation)
  end

end
