# frozen_string_literal: true

module Pipelines
  module Guards
    class ShowGuard < BaseGuard
      def call
        return Success(true) if merchant_id.nil?
        return Success(true) if merchant_exists?

        Failure(:forbidden)
      end

      private

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil).presence
      end

      def merchant_exists?
        return false unless merchant_id.present?

        target_user.merchant_users.exists?(merchant_id:)
      end
    end
  end
end
