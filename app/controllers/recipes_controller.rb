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
    recipes = Recipe.parse(client.recipes_index)

    if recipes
      Recipe.delete_all
      recipes.each(&:save)
      flash[:notice] = "Recipes successfully synced."
    else
      flash[:danger] = "There was a problem syncing the recipes."
    end

    redirect_to recipes_path
  end

  private

  def client
    @client ||= PaprikaApiClient.new(ENV["paprika_email"], ENV["paprika_password"])
  end
end
