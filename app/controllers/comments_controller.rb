class CommentsController < ApplicationController
  before_action :require_user

  def create
    recipe = Recipe.find(params[:recipe_id])
    comment = Comment.new(comment_params)

    comment.recipe = recipe
    comment.user = current_user

    if comment.save
      flash[:success] = "Your comment was submitted"
    else
      flash[:danger] = "There was a problem submitting your comment."
    end

    redirect_to recipe_path(recipe)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :recipe_id)
  end
end