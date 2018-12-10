class CommentsController < ApplicationController
  before_action :require_user

  def index
    recipe = Recipe.find(params[:recipe_id])
    render recipe.comments
  end

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = Comment.new(comment_params)

    comment.recipe = recipe
    comment.user = current_user
    comment.save

    if request.xhr?
      render comment
    else
      redirect_to recipe_path(recipe)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :recipe_id)
  end
end