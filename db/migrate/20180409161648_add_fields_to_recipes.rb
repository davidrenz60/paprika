class AddFieldsToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :rating, :string
    add_column :recipes, :ingredients, :text
    add_column :recipes, :directions, :text
    add_column :recipes, :photo_url, :string
    add_column :recipes, :created, :string
    add_column :recipes, :uid, :string
  end
end
