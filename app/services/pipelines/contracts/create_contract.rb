# frozen_string_literal: true

module Pipelines
  module Contracts
    class CreateContract < BaseContract
      params do
        required(:merchant_id).filled(:string)
        required(:financial_institution_id).filled(:string)
      end
    end
  end
end
