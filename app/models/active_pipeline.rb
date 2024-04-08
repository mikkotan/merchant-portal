# frozen_string_literal: true

class ActivePipeline < ApplicationRecord
  belongs_to :pipeline, foreign_key: :financial_institutions_id
  belongs_to :merchant
end
