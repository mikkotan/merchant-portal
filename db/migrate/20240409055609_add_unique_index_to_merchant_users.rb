class AddUniqueIndexToMerchantUsers < ActiveRecord::Migration[7.1]
  def change
    add_index :merchant_users, %i[merchant_id user_id], unique: true
  end
end
