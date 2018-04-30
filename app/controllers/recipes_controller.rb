require 'paprika_api'

class RecipesController < ApplicationController
  before_action :require_admin, only: [:sync]

  def index
    @recipes = Recipe.all.order(:name)
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])
  end

  def sync
    Recipe.sync
    flash[:info] = "Recipes successfully synced."
    redirect_to recipes_path
  end
end
