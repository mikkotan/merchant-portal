# frozen_string_literal: true

module Pipelines
  module Operations
    class CreateOperation < BaseService
      def initialize(params)
        @params = params
      end

      def call
        pipeline = Pipeline.new(pipeline_params)

        if pipeline.save
          Success(pipeline)
        else
          Failure([:unprocessable_entity, pipeline.errors.full_messages.join(', ')])
        end
      end

      private

      attr_reader :params

      def pipeline_params
        {
          merchant_id: params.fetch(:merchant_id),
          financial_institution_id: params.fetch(:financial_institution_id),
          status: Pipeline.statuses[:pending]
        }
      end
    end
  end
end
