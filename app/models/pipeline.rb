# frozen_string_literal: true

class Pipeline < ::ApplicationRecord
  self.table_name = :financial_institutions

  has_many :active_pipelines
end