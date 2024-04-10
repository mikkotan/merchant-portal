# frozen_string_literal: true

module Merchants
  module Operations
    class ListOperation < BaseService
      def initialize(params)
        @user_id = params.fetch(:user_id)
      end

      def call
        merchants = Merchant.by_user_id(user_id)
        Success(merchants)
      end

      private

      attr_reader :user_id
    end
  end
end
