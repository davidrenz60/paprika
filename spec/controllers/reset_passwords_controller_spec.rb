require 'rails_helper'

describe ResetPasswordsController do
  describe "GET show" do
    context "with invalid token" do
      let(:user) { Fabricate(:user, token: "123") }

      before do
        get :show, params: { token: "abc"}
      end

      it "redirects to the invalid token path" do
        expect(response).to redirect_to invalid_token_path
      end
    end

    context "with expired token" do
      let(:user) { Fabricate(:user, token: "123") }

      before do
        user.update_column(:token_expiration, Time.now - 1.minutes)
        get :show, params: { token: user.token }
      end

      it "redirects to the invalid token path" do
        expect(response).to redirect_to expired_token_path
      end
    end
  end

  describe "POST create" do
    context "with valid token" do
      let!(:user) { Fabricate(:user, token: "123", token_expiration: Time.now + 1.minutes) }

      before do
        post :create, params: { password: "password", token: "123" }
      end

      it "sets a new password for the user" do
        expect(user.reload.authenticate("password")).to eq(user)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to root_path
      end

      it "automatically logs in the user" do
        expect(session[:user_id]).to eq(user.id)
      end

      it "sets a flash message" do
        expect(flash[:success]).not_to be_nil
      end

      it "clears the user's token" do
        expect(user.reload.token).to be_nil
      end

      it "expired the user's token" do
        expect(user.reload.token_expiration).to be_nil
      end
    end

    context "with invalid token" do
      let!(:user) { Fabricate(:user, token: "123", token_expiration: Time.now + 1.minutes, password: "old_pass") }

      before do
        post :create, params: { password: "new_pass", token: "abc" }
      end

      it "does not set a new password" do
        expect(user.reload.authenticate("old_pass")).to eq(user)
      end

      it "redirects to the invalid token page" do
        expect(response).to redirect_to invalid_token_path
      end
    end

    context "with expired token" do
      let!(:user) { Fabricate(:user, token: "123", token_expiration: Time.now - 1.minutes, password: "old_pass") }

      before do
        post :create, params: { password: "new_pass", token: "123" }
      end

      it "does not set a new password" do
        expect(user.reload.authenticate("old_pass")).to eq(user)
      end

      it "redirects to the expired token page" do
        expect(response).to redirect_to expired_token_path
      end
    end

    context "with invalid password" do
      let!(:user) { Fabricate(:user, token: "123", token_expiration: Time.now + 1.minutes, password: "old_pass") }

      before do
        post :create, params: { password: "", token: "123" }
      end

      it "renders the show template" do
        expect(response).to render_template(:show)
      end

      it "does not set a new password" do
        expect(user.reload.authenticate("old_pass")).to eq(user)
      end
    end
  end
end
