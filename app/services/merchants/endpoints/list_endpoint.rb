# frozen_string_literal: true

module Merchants
  module Endpoints
    class ListEndpoint < BaseEndpointService
      private

      def process
        merchants = yield list_merchants.call(params)

        Success({ data: present(merchants) })
      end

      def contract
        @contract ||= Merchants::Contracts::ListContract.new
      end

      def guard
        @guard ||= Merchants::Guards::ListGuard.new(current_user, user_id:)
      end

      def user_id
        @user_id ||= params.fetch(:user_id)
      end

      def list_merchants
        @list_merchants ||= Merchants::Operations::ListOperation
      end

      def present(merchants)
        Merchants::Presenters::ListPresenter.new(merchants).serialize
      end
    end
  end
end
