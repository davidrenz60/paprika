require 'rails_helper'

describe RecipesController do
  describe "POST sync" do
    context "with valid data and empty database" do
      let(:recipes) { Array.new(5) { Fabricate.attributes_for(:recipe) } }

      before do
        set_admin_user
        expect_any_instance_of(PaprikaApiClient).to receive(:recipes_index).and_return(recipes)
        post :sync
      end

      it "deletes the current recipes and saves the new ones to the database" do
        expect(Recipe.count).to eq(5)
      end

      it "sets a flash message" do
        expect(flash[:notice]).not_to be_nil
      end

      it "redirects to the reipces path" do
        expect(response).to redirect_to recipes_path
      end
    end

    context "with invalid data and empty database" do
      let(:recipes) { Array.new(4) { Fabricate.attributes_for(:recipe) } }

      before do
        set_admin_user
        expect_any_instance_of(PaprikaApiClient).to receive(:recipes_index).and_return(recipes)
        recipes.push(Fabricate.attributes_for(:recipe, name: ""))
        post :sync
      end

      it "does not change the current receipes in the database" do
        expect(Recipe.count).to eq(0)
      end

      it "sets a flash message" do
        expect(flash[:danger]).not_to be_nil
      end

      it "redirects to the reipces path" do
        expect(response).to redirect_to recipes_path
      end
    end

    context "with valid data and existing recipes in the database" do
      let(:recipes) { Array.new(3) { Fabricate.attributes_for(:recipe) } }

      before do
        5.times { Fabricate(:recipe) }
        set_admin_user
        expect_any_instance_of(PaprikaApiClient).to receive(:recipes_index).and_return(recipes)
        post :sync
      end

      it "refreshes the database with the new recipes" do
        expect(Recipe.count).to eq(3)
        expect(Recipe.first.name).to eq(recipes.first["name"])
      end

      it "sets a flash message" do
        expect(flash[:notice]).not_to be_nil
      end

      it "redirects to the recipes_path" do
        expect(response).to redirect_to recipes_path
      end
    end

    context "with invalid data and existing recipes in the database" do
      let(:recipes) { Array.new(3) { Fabricate.attributes_for(:recipe) } }

      before do
        5.times { Fabricate(:recipe) }
        recipes.push(Fabricate.attributes_for(:recipe, name: ""))
        set_admin_user
        expect_any_instance_of(PaprikaApiClient).to receive(:recipes_index).and_return(recipes)
        post :sync
      end

      it "refreshes the database with the new recipes" do
        expect(Recipe.count).to eq(5)
      end

      it "sets a flash message" do
        expect(flash[:danger]).not_to be_nil
      end

      it "redirects to the recipes_path" do
        expect(response).to redirect_to recipes_path
      end
    end

    it_behaves_like "require admin" do
      user = Fabricate(:user)
      let(:action) { post :sync, params: { email: user.username, password: user.password } }
    end
  end
end
