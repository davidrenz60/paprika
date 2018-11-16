require 'rails_helper'

describe RecipesController do
  describe "POST sync" do
    context "with successful sync" do
      let(:sync) { double("sync", successful?: true) }

      before do
        set_admin_user
        expect_any_instance_of(PaprikaSync).to receive(:call).and_return(sync)
        post :sync
      end

      it "sets a flash messsage" do
        expect(flash[:info]).not_to be_nil
      end

      it "redirects to the recipes path" do
        expect(response).to redirect_to recipes_path
      end
    end

    context "with unsuccessful sync" do
      let(:sync) { double("sync", successful?: false, error_message: "error") }

      before do
        set_admin_user
        expect_any_instance_of(PaprikaSync).to receive(:call).and_return(sync)
        post :sync
      end

      it "sets a flash messsage" do
        expect(flash[:danger]).not_to be_nil
      end

      it "redirects to the recipes path" do
        expect(response).to redirect_to recipes_path
      end
    end

    it_behaves_like "require admin" do
      let(:action) { post :sync }
    end
  end

  describe "POST send_email" do
    context "with valid email address" do
      let!(:recipe) { Fabricate(:recipe) }

      it "sends an email through an ajax request" do
        post :send_email, xhr: true, params: { id: recipe.id, email: "dave@test.com" }

        expect(ActionMailer::Base.deliveries.count).to eq(1)
      end

      it "sends an email through an html request" do
        post :send_email, params: { id: recipe.id, email: "dave@test.com" }

        expect(ActionMailer::Base.deliveries.count).to eq(1)
        expect(response).to redirect_to recipe_path(recipe.slug)
      end
    end

    context "with invalid email address" do
      let!(:recipe) { Fabricate(:recipe) }

      it "does not send an email" do
        post :send_email, xhr: true, params: { id: recipe.id, email: "" }
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end
    end
  end
end
