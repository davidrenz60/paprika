class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, :password_digest, :role
      t.timestamps
    end
  end
end
