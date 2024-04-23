# frozen_string_literal: true

module Partners
  module Operations
    class ListOperation < BaseService
      def initialize(params)
        @params = params
      end

      def call
        scope = base_scope
        scope = scope.active(merchant_id) if active
        scope = scope.by_stage(stage) if stage.present?

        Success(scope)
      end

      private

      attr_reader :params

      def base_scope
        Partner.includes(:pipelines)
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id, nil)
      end

      def active
        @active ||= params.fetch(:active, nil)
      end

      def stage
        @stage ||= params.fetch(:stage, nil)
      end
    end
  end
end
