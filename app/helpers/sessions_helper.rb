module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if @current_user.nil?
      User.find_by(id: session[:user_id])
    else
      @current_user
    end
    @current_user  = @current_user || User.find_by(id: session[:user_id])
  end
end
