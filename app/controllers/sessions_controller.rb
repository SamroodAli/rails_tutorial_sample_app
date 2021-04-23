class SessionsController < ApplicationController
  def new; end

  def create
    render 'new'
  end

  def destroy
  end

  private
  def user_params
    params.require(:sessions).permit(:email, :password)
  end


end
