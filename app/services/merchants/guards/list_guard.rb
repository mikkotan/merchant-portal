# frozen_string_literal: true

module Merchants
  module Guards
    class ListGuard < BaseService
      def initialize(target_user, options = {})
        @target_user = target_user
        @options = options
      end

      def call
        return Success(user_id) if target_user.internal?
        return Failure(:forbidden) unless user_id.presence == target_user.id

        Success(user_id)
      end

      private

      attr_reader :target_user, :options

      def user_id
        @user_id ||= options.fetch(:user_id, nil)
      end
    end
  end
end
