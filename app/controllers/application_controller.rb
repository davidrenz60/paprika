class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :recipes_count

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def login(user)
    session[:user_id] = user.id
  end

  def require_admin
    access_denied unless current_user && current_user.admin?
  end

  def access_denied
    flash[:danger] = "You are not authorized to do that."
    redirect_to root_path
  end
end
