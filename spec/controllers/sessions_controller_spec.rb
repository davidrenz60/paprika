require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    before do
      set_current_user
      get :new
    end

    it "redirects to the home_page if already logged in." do
      expect(response).to redirect_to root_path
    end

    it "sets a flash message if already logged in." do
      expect(flash[:notice]).not_to be_nil
    end
  end

  describe 'POST create' do
    context 'with valid credentials' do
      let(:user) { Fabricate(:user) }

      before do
        post :create, params: { username: user.username, password: user.password }
      end

      it 'sets the session user_id' do
        expect(session[:user_id]).to eq(user.id)
      end

      it 'redirects to the home page' do
        expect(response).to redirect_to root_path
      end

      it 'sets a flash message' do
        expect(flash[:notice]).not_to be_nil
      end
    end

    context 'with invalid credentials' do
      let(:user) { Fabricate(:user) }

      before { post :create, params: { username: user.username, password: user.password + "123" } }

      it 'does not set the session user_id' do
        expect(session[:user_id]).to be_nil
      end

      it 'sets a flash message' do
        expect(flash[:danger]).not_to be_nil
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end
    end
  end

  describe 'POST destroy' do
    before do
      set_current_user
      post :destroy
    end

    it 'sets the session user_id to nil' do
      expect(session[:user_id]).to be_nil
    end

    it 'redirects to root' do
      expect(response).to redirect_to root_path
    end

    it 'sets a flash message' do
      expect(flash[:notice]).not_to be_nil
    end
  end
end
