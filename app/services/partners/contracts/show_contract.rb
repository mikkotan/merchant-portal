# frozen_string_literal: true

module Partners
  module Contracts
    class ShowContract < BaseContract
      params do
        required(:id).filled(:string)
        optional(:merchant_id).maybe(:string)
      end
    end
  end
end
