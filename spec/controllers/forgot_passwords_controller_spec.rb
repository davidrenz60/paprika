require 'rails_helper'

describe ForgotPasswordsController do
  describe "POST create" do
    context "with valid email" do
      let(:user) { Fabricate(:user) }

      before do
        post :create, params: { email: user.email }
      end

      it "sends and email to the proper email address" do
        expect(ActionMailer::Base.deliveries.last.to.first).to eq(user.email)
      end

      it "generates a user token" do
        expect(user.reload.token).not_to be_nil
      end

      it "sets a flash message" do
        expect(flash[:success]).not_to be_nil
      end

      it "redirects to the login page" do
        expect(response).to redirect_to login_path
      end
    end

    context "with invalid email" do
      let(:user) { Fabricate(:user) }

      before do
        post :create, params: { email: "test@example.com" }
      end

      it "does not send an email" do
        expect(ActionMailer::Base.deliveries.count).to eq(0)
      end

      it "sets a flash message" do
        expect(flash[:danger]).not_to be_nil
      end
    end
  end
end
