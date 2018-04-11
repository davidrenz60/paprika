class AddSlugToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :slug, :string
  end
end
