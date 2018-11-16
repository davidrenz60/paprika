class CreateUserRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_recipes do |t|
      t.integer :recipe_id, :user_id
    end
  end
end
