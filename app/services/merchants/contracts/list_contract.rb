# frozen_string_literal: true

module Merchants
  module Contracts
    class ListContract < BaseContract
      params do
        required(:user_id).filled(:string)
      end
    end
  end
end
