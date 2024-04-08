# frozen_string_literal: true

class ActivePipeline < ::ApplicationRecord
  belongs_to :pipeline
  belongs_to :merchant
end