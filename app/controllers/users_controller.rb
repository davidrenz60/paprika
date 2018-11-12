class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      flash[:notice] = "You are registered and logged in as #{@user.username}."
      redirect_to root_path
    else
      flash.now[:danger] = "There was a problem registering."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end
end