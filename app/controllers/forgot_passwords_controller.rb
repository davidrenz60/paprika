class ForgotPasswordsController < ApplicationController
  def create
    email = params[:email]
    user = User.find_by(email: email)

    if user
      user.generate_token!
      AppMailer.send_forgot_password(email, user).deliver_now

      flash[:success] = "An email was sent to reset your password."
      redirect_to login_path
    else
      flash[:danger] = email.blank? ? "Email cannot be blank" : "Email address does not exist."
      render :new
    end
  end
end