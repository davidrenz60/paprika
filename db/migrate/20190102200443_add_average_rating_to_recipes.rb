class AddAverageRatingToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :average_rating, :string
  end
end
