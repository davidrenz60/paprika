class AppMailer < ActionMailer::Base
  default from: 'bernie@renz-recipes.com'
  helper ApplicationHelper

  def send_forgot_password(email, user)
    @email = email
    @user = user
    mail(to: @email, subject: "Reset Password")
  end

  def send_recipe(recipe, email)
    return if email.blank?
    @recipe = recipe
    @email = email
    mail(to: @email, subject: "Here is your recipe!")
  end

  def send_invitation(email, username, message)
    @email = email
    @message = message
    @username = username
    mail(to: @email, subject: "Join Renz Recipes")
  end
end
