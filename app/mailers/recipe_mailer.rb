class RecipeMailer < ActionMailer::Base
  default from: 'bernie@renz-recipes.com'

  def recipe_email
    mail(to: email)
  end
end
