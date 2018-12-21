require 'rails_helper'

describe InvitationsController do
  describe "post CREATE" do
    let(:user) { Fabricate(:user) }

    before do
      set_current_user(user)
      post :create, params: { email: "test@example.com", message: "message" }
    end

    it "sends an invitation email" do
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end

    it "sets a flash message" do
      expect(flash[:success]).not_to be_nil
    end

    it "redirects to the home page" do
      expect(response).to redirect_to root_path
    end


    it_behaves_like "require user" do
      let(:action) { post :create, params: { email:"test@example.com", message: "message" } }
    end
  end
end
