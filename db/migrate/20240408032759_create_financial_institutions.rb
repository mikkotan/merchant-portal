class CreateFinancialInstitutions < ActiveRecord::Migration[7.1]
  def change
    create_table :financial_institutions, id: :uuid do |t|
      t.string :name, null: false
      t.string :about
      t.string :founded_in
      t.string :company_website, null: false
      t.integer :stage, null: false, default: 0
      t.string :categories, array: true, default: []
      t.timestamps
    end
  end
end
