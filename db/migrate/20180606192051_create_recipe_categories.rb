class CreateRecipeCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :recipe_categories do |t|
      t.string :recipe_uid, :category_uid

      t.timestamps
    end
  end
end
