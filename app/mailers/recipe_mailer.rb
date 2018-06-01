class RecipeMailer < ActionMailer::Base
  default from: 'bernie@renz-recipes.com'
  helper ApplicationHelper

  def recipe_email(recipe, email)
    @recipe = recipe
    @email = email
    mail(to: @email, subject: "Here is your recipe!")
  end
end
