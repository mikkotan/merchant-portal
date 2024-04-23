# frozen_string_literal: true

module Partners
  module Contracts
    class ListContract < BaseContract
      params do
        required(:merchant_id).filled(:string)
        required(:user_id).filled(:string)
        optional(:active).filled(:bool)
      end
    end
  end
end
