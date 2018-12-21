class InvitationsController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def new; end

  def create
    email = params[:email]
    message = params[:message]
    username = current_user.username

    AppMailer.send_invitation(email, username, message).deliver_now

    flash[:success] = "Your invitation was sent!"
    redirect_to root_path
  end
end