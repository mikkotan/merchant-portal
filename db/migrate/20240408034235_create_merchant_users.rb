class CreateMerchantUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :merchant_users, id: :uuid do |t|
      t.belongs_to :merchant, type: :uuid, null: false, foreign_key: true
      t.belongs_to :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
