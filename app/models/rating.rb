class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :recipe

  validates :rating, presence: true

  after_save :update_recipe_rating

  private

  def update_recipe_rating
    recipe.update_average_rating
  end
end