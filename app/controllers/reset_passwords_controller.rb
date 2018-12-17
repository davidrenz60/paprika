class ResetPasswordsController < ApplicationController
  before_action :user, :check_valid_user, :check_expired_token, only: [:show, :create]

  def show
    @token = params[:token]
  end

  def create
    user.password = params[:password]

    if user.save
      user.clear_token
      login user
      flash[:success] = "You successfully changed your password. You are now logged in as #{current_user.username}"
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def user
    @user ||= User.find_by(token: params[:token])
  end

  def check_expired_token
    redirect_to expired_token_path if user && user.expired_token?
  end

  def check_valid_user
    redirect_to invalid_token_path unless user
  end
end