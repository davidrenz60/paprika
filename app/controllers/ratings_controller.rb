class RatingsController < ApplicationController
  before_action :require_user, only: [:create]

  def create
    recipe = Recipe.friendly.find(params[:recipe_id])
    rating = Rating.find_by(recipe: recipe, user: current_user)

    if rating
      rating.update(rating: params[:rating])
    else
      Rating.create(recipe: recipe, user: current_user, rating: params[:rating]).save
    end

    recipe.reload
    html = render_to_string partial: 'ratings/rating_form', locals: { recipe: recipe, rating: params[:rating] }

    response = {
      html: html,
      user_rating: params[:rating],
      average_rating: recipe.average_rating
    }

    render json: response.to_json
  end
end