require 'paprika_api'

class RecipesController < ApplicationController
  before_action :require_admin, only: [:sync]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.friendly.find(params[:id])
  end

  def sync
    Recipe.delete_all
    recipes_data = client.recipes_index

    recipes = recipes_data.map do |data|
      Recipe.new(
        name: data["name"],
        rating: data["rating"],
        ingredients: data["ingredients"],
        directions: data["directions"],
        photo_url: data["photo_url"],
        created: data["created"],
        uid: data["uid"]
      )
    end

    Recipe.transaction do
      recipes.each(&:save)
    end

    redirect_to recipes_path
  end

  private

  def client
    @client ||= PaprikaApiClient.new(ENV["paprika_email"], ENV["paprika_password"])
  end
end
