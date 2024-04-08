# frozen_string_literal: true

class CreateActivePipelines < ActiveRecord::Migration[7.1]
  def change
    create_table :active_pipelines, id: :uuid do |t|
      t.belongs_to :merchant, type: :uuid, null: false, foreign_key: true
      t.belongs_to :financial_institutions, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
