# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :active_pipelines, foreign_key: :financial_institutions_id
end
