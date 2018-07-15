class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:notice] = "You are already logged in."
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      login(user)
      flash[:notice] = "You are logged in as #{user.username}."
      redirect_to root_path
    else
      flash.now[:danger] = "There was a problem logging in."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to root_path
  end
end