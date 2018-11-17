require 'rails_helper'

describe CommentsController do
  describe "POST create" do
    context "with valid params" do
      let(:recipe) { Fabricate(:recipe) }
      let(:user) { Fabricate(:user) }

      before do
        set_current_user(user)
        post :create, params: { comment: { body: "Testing comments." }, recipe_id: recipe.id }
      end

      it "creates a new comment" do
        expect(Comment.count).to eq(1)
      end

      it "associates the comment with the recipe" do
        expect(recipe.comments.count).to eq(1)
      end

      it "associates the comment with the current_user" do
        expect(recipe.comments.first.user).to eq(user)
      end

      it "redirects to the recipe path" do
        expect(response).to redirect_to recipe_path(recipe)
      end

      it "sets a flash message" do
        expect(flash[:success]).not_to be_nil
      end
    end

    context "with invalid params" do
      let(:recipe) { Fabricate(:recipe) }
      let(:user) { Fabricate(:user) }

      before do
        set_current_user(user)
        post :create, params: { comment: { body: "" }, recipe_id: recipe.id }
      end

      it "does not create a comment" do
        expect(Comment.count).to eq(0)
      end

      it "redirects to the recipe path" do
        expect(response).to redirect_to recipe_path(recipe)
      end

      it "sets a flash message" do
        expect(flash[:danger]).not_to be_nil
      end
    end

    it_behaves_like "require user" do
      let(:action) { post :create, params: { recipe_id: 1 } }
    end
  end
end
