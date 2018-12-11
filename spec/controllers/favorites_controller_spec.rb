require 'rails_helper'

describe FavoritesController do
  describe "POST create" do
    it "favorites a recipe for a user" do
      user = Fabricate(:user)
      set_current_user(user)
      recipe = Fabricate(:recipe)
      post :create, xhr: true, params: { recipe_id: recipe.id }

      expect(user.favorite_recipes).to include(recipe)
    end

    it "does not favorite a recipe that has already been favorited" do
      user = Fabricate(:user)
      set_current_user(user)
      recipe = Fabricate(:recipe)

      UserRecipe.create(user_id: user.id, recipe_id: recipe.id)
      post :create, xhr: true, params: { recipe_id: recipe.id }

      expect(UserRecipe.count).to eq(1)
    end

    it_behaves_like "require user" do
      recipe = Fabricate(:recipe)
      let(:action) { post :create, params: { recipe_id: recipe.id } }
    end
  end

  describe "DELETE destroy" do
    it "unfavorites a recipe that was already favorited" do
      user = Fabricate(:user)
      set_current_user(user)
      recipe = Fabricate(:recipe)
      UserRecipe.create(user_id: user.id, recipe_id: recipe.id)

      delete :destroy, xhr: true, params: { recipe_id: recipe.id }
      expect(UserRecipe.count).to eq(0)
    end

    it "does not unfavorite a recipe that was not previously favorited" do
      user = Fabricate(:user)
      set_current_user(user)
      recipe = Fabricate(:recipe)
      expect { delete :destroy, xhr: true, params: { recipe_id: recipe.id } }.not_to raise_error
    end

    it_behaves_like "require user" do
      recipe = Fabricate(:recipe)
      let(:action) { delete :destroy, params: { recipe_id: recipe.id } }
    end
  end
end
