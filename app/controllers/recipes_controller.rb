class RecipesController < ApplicationController
  before_action :require_admin, only: [:sync]

  def index
    @recipes = if params[:sort_by] == "created"
                 Recipe.all.order(created: :desc)
               elsif params[:sort_by] == "rating"
                 Recipe.order('average_rating DESC NULLS LAST')
               else
                 Recipe.all.order(:name)
               end
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])
    @categories = @recipe.categories.map(&:name).join(', ')
    @comment = Comment.new
  end

  def sync
    sync = PaprikaSync.new.call

    if sync.successful?
      flash[:success] = "Recipes successfully synced."
    else
      flash[:danger] = sync.error_message
    end

    redirect_to recipes_path
  end

  def send_email
    recipe = Recipe.find(params[:id])
    email = params[:email]
    AppMailer.send_recipe(recipe, email).deliver_now

    respond_to do |format|
      format.html { redirect_to recipe_path(recipe) }
      format.js
    end
  end
end
