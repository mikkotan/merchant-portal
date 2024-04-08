# frozen_string_literal: true

class Pipeline < ApplicationRecord
  self.table_name = :financial_institutions

  has_many :active_pipelines, foreign_key: :financial_institutions_id

  enum stage: {
    contracting: 0,
    implementation: 10,
    live: 20
  }
end
