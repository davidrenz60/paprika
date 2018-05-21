require 'paprika_api'

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
    Recipe.sync
    flash[:info] = "Recipes successfully synced."
    redirect_to recipes_path
  end

  def send_email
    require 'pry'; binding.pry
    @recipe = Recipe.friendly.find(params[:id])
    redirect_to recipe_path(@recipe)
  end
end
