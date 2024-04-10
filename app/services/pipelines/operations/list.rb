# frozen_string_literal: true

module Pipelines
  module Operations
    class List < BaseService
      def initialize(params)
        @params = params
      end

      def call
        scope = base_scope
        scope = scope.active(merchant_id, user_id) if filter_by_active?

        Success(scope)
      end

      private

      attr_reader :params

      def base_scope
        Pipeline.includes(:active_pipelines)
      end

      def user_id
        @user_id ||= params.fetch(:user_id, nil)
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id, nil)
      end

      def active
        @active ||= params.fetch(:active, nil)
      end

      def filter_by_active?
        return false unless user_id.present? && merchant_id.present?

        active.present? && active == 'true'
      end
    end
  end
end
