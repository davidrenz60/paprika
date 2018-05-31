require 'rails_helper'

describe RecipesController do
  describe "POST sync" do
    it "sets a flash messsage" do
      set_admin_user
      expect_any_instance_of(PaprikaApiClient).to receive(:recipes_data).and_return([])
      post :sync
      expect(flash[:info]).not_to be_nil
    end

    it "redirects to the recipes path" do
      set_admin_user
      expect_any_instance_of(PaprikaApiClient).to receive(:recipes_data).and_return([])
      post :sync
      expect(response).to redirect_to recipes_path
    end

    it_behaves_like "require admin" do
      user = Fabricate(:user)
      let(:action) { post :sync }
    end
  end

  describe "send_email" do
    context "with valid email address" do
      let!(:recipe) { Fabricate(:recipe) }

      it "sends an email through an ajax request" do
        post :send_email, xhr: true, params: { recipe_id: recipe.id, email: "dave@test.com" }

        expect(ActionMailer::Base.deliveries.count).to eq (1)
      end

      it "sends an email through an html request" do
        post :send_email, params: { recipe_id: recipe.id, email: "dave@test.com" }

        expect(ActionMailer::Base.deliveries.count).to eq (1)
        expect(response).to redirect_to recipe_path(recipe.slug)
      end
    end

    context "with invalid email address" do
      let!(:recipe) { Fabricate(:recipe) }

      it "does not send an email" do
        post :send_email, xhr: true, params: { recipe_id: recipe.id, email: "" }
        expect(ActionMailer::Base.deliveries.count).to eq (0)
      end
    end
  end
end
