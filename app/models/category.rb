class Category < ActiveRecord::Base
  has_many :recipe_categories, primary_key: :uid, foreign_key: :category_uid
  has_many :recipes, through: :recipe_categories
end