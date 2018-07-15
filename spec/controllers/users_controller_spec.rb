require 'rails_helper'

describe UsersController do
  describe "POST create" do
    context "with valid credentials" do
      before do
        post :create, params: { user: { username: "dave", password: "abc" } }
      end

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "automatically signs the new user in" do
        expect(session[:user_id]).not_to be_nil
      end

      it 'sets a flash message' do
        expect(flash[:notice]).not_to be_nil
      end

      it "redirects to the root path" do
        expect(response).to redirect_to root_path
      end
    end

    context "with invalid credentials" do
      before do
        post :create, params: { user: { username: "", password: "abc" } }
      end

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it 'sets a flash message' do
        expect(flash[:danger]).not_to be_nil
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end
end