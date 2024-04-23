# frozen_string_literal: true

module Pipelines
  module Contracts
    class ActivateContract < BaseContract
      params do
        required(:id).filled(:string)
      end
    end
  end
end
