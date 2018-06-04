class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, :uid, :parent_uid, :order_flag
      t.timestamps
    end
  end
end
