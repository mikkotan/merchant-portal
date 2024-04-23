# frozen_string_literal: true

module Pipelines
  module Operations
    class ActivateOperation < BaseService
      def initialize(pipeline)
        @pipeline = pipeline
      end

      def call
        return Failure(:invalid_status) unless pipeline.status_pending?

        pipeline.update(status: Pipeline.statuses[:active])

        Success(pipeline)
      end

      private

      attr_reader :pipeline
    end
  end
end
