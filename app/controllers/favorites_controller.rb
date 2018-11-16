class FavoritesController < ApplicationController
  before_action :require_user, only: [:create, :index, :destroy]

  def index; end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = UserRecipe.new(recipe_id: params[:recipe_id], user_id: current_user.id).save

    respond_to do |format|
      format.html do
        if @favorite
          flash[:notice] = "You favorited this recipe"
        else
          flash[:danger] = "You have already favorited this recipe"
        end
        redirect_to recipe_path(@recipe)
      end

      format.js
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    @favorite = UserRecipe.find_by(recipe_id: @recipe.id, user_id: current_user.id)

    @favorite.destroy if @favorite

    respond_to do |format|
      format.html do
        if @favorite
          flash[:notice] = "You unfavorited this recipe"
        else
          flash[:danger] = "You have not favorited this recipe"
        end
        redirect_to recipe_path(@recipe)
      end

      format.js
    end

  end
end
