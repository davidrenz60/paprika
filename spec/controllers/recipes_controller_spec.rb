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
end
