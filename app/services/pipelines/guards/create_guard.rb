# frozen_string_literal: true

module Pipelines
  module Guards
    class CreateGuard < BaseGuard
      def call
        return Success(true) if target_user.internal?
        return Failure(:forbidden) unless merchant_exists?

        Success(true)
      end

      private

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil)
      end

      def merchant_exists?
        return false unless merchant_id.present?

        target_user.merchant_users.exists?(merchant_id:)
      end
    end
  end
end
