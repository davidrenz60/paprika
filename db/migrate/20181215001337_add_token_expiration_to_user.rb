class AddTokenExpirationToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :token_expiration, :datetime
  end
end
