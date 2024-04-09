class AddUniqueIndexToActivePipelines < ActiveRecord::Migration[7.1]
  def change
    rename_column :active_pipelines, :financial_institutions_id, :financial_institution_id
    add_index :active_pipelines, %i[merchant_id financial_institution_id], unique: true
  end
end
