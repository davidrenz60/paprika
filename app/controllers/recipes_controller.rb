class RecipesController < ApplicationController
  before_action :require_admin, only: [:sync]

  def index
    @recipes = if params[:sort_by] == "created"
                 Recipe.all.order(created: :desc)
               else
                 Recipe.all.order(:name)
               end
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])
  end

  def sync
    sync = PaprikaSync.new.call

    if sync.successful?
      flash[:info] = "Recipes successfully synced."
    else
      flash[:danger] = sync.error_message
    end

    redirect_to recipes_path
  end

  def send_email
    recipe = Recipe.find(params[:recipe_id])
    email = params[:email]
    RecipeMailer.recipe_email(recipe, email).deliver_now

    respond_to do |format|
      format.html { redirect_to recipe_path(recipe) }
      format.js
    end
  end
end
