require 'rails_helper'

describe RatingsController do
  describe "POST create" do
    context "with no prior user review" do
      let(:user) { Fabricate(:user) }
      let(:recipe) { Fabricate(:recipe) }

      it "creates a new review" do
        set_current_user(user)
        post :create, params: { recipe_id: recipe.id, rating: 3 }
        expect(Rating.count).to eq(1)
      end
    end

    context "with previous user review" do
      let(:user) { Fabricate(:user) }
      let(:recipe) { Fabricate(:recipe) }

      it "does not create a new review" do
        set_current_user(user)
        Fabricate(:rating, user: user, recipe: recipe)
        post :create, params: { recipe_id: recipe.id, rating: 3 }

        expect(Rating.count).to eq(1)
      end

      it "updates the user's review" do
        set_current_user(user)
        Fabricate(:rating, user: user, recipe: recipe, rating: 1)
        post :create, params: { recipe_id: recipe.id, rating: 5 }

        expect(user.ratings.first.rating).to eq(5)
      end

      it "updates the average_rating for the recipe" do
        set_current_user(user)
        Fabricate(:rating, user: user, recipe: recipe, rating: 1)
        post :create, params: { recipe_id: recipe.id, rating: 5 }

        expect(recipe.reload.average_rating).to eq("5.0")
      end
    end

    it_behaves_like "require user" do
      let(:action) { post :create, params: { recipe_id: 1, rating: 1 } }
    end
  end
end
