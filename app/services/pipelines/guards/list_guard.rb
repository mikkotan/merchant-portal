# frozen_string_literal: true

module Pipelines
  module Guards
    class ListGuard < BaseService
      def initialize(target_user, options = {})
        @target_user = target_user
        @options = options
      end

      def call
        return Success(user_id) if target_user.internal?
        return Failure(:forbidden) unless user_id.presence == target_user.id
        return Failure(:forbidden) unless merchant_exists?

        Success(user_id)
      end

      private

      attr_reader :target_user, :options

      def user_id
        @user_id ||= options.fetch(:user_id, nil)
      end

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
