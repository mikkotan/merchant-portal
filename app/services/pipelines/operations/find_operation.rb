# frozen_string_literal: true

module Pipelines
  module Operations
    class FindOperation < BaseService
      def initialize(pipeline_id)
        @pipeline_id = pipeline_id
      end

      def call
        pipeline = Pipeline.find_by(id: pipeline_id)
        return Success(pipeline) if pipeline.present?

        Failure(:not_found)
      end

      private

      attr_reader :pipeline_id
    end
  end
end
