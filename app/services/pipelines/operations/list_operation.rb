# frozen_string_literal: true

module Pipelines
  module Operations
    class ListOperation < BaseService
      def initialize(params)
        @params = params
      end

      def call
        scope = base_scope
        scope = scope.active(merchant_id) if filter_by_active?

        Success(scope)
      end

      private

      attr_reader :params

      def base_scope
        Pipeline.includes(:active_pipelines)
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id, nil)
      end

      def active
        @active ||= params.fetch(:active, nil)
      end

      def filter_by_active?
        return false unless merchant_id.present?

        active.present? && active == 'true'
      end
    end
  end
end
