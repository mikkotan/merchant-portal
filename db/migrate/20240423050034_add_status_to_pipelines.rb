class AddStatusToPipelines < ActiveRecord::Migration[7.1]
  def change
    add_column :pipelines, :status, :integer, default: 0, null: false
  end
end
