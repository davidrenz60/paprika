class AddTokenToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :token, :string
  end
end
