class FavoritesController < ApplicationController
  before_action :require_user, only: [:create, :index, :destroy]

  def index
    @recipes = current_user.favorite_recipes.order(:name)
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    UserRecipe.new(recipe_id: params[:recipe_id], user_id: current_user.id).save

    render partial: 'favorites/unfavorite_link', locals: { recipe: recipe }
  end

  def destroy
    recipe = Recipe.find_by(id: params[:recipe_id])
    favorite = UserRecipe.find_by(recipe_id: params[:recipe_id], user_id: current_user.id)

    favorite.destroy if favorite

    render partial: 'favorites/favorite_link', locals: { recipe: recipe }
  end
end
