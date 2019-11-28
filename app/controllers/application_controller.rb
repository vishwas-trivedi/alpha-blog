class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  # This is going to be used to route our views
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # This is going to be used to toute our views
  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end

end
