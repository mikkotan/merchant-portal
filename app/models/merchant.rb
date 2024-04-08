# frozen_string_literal: true

class Merchant < ::ApplicationRecord
  has_many :active_pipelines
end
