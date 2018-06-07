class RecipeCategory < ActiveRecord::Base
  belongs_to :recipe, primary_key: :uid, foreign_key: :recipe_uid
  belongs_to :category, primary_key: :uid, foreign_key: :category_uid
end