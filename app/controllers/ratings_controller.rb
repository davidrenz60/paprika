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

    render partial: 'ratings/rating_form', locals: { recipe: recipe, rating: params[:rating] }
  end
end