class SessionsController < ApplicationController
  def new;end

  def create
    user = User.find_by(email: user_params[:email])
    if user && user.authenticate(user_params[:password])
      reset_sessions
      log_in user
      redirect_to user
    else  
      flash.now[:danger]= "Invalid email/password combination."
      render "new"
    end 
  end

  def destroy;ruend

  private
  def user_params
    params.require(:session).permit(:email, :password)
  end

end
