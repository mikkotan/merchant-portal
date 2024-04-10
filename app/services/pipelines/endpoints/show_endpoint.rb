# frozen_string_literal: true

module Pipelines
  module Endpoints
    class ShowEndpoint < BaseEndpointService
      private

      def process
        pipeline = yield find_pipeline.call(pipeline_id)

        Success({ data: present(pipeline) })
      end

      def guard
        @guard ||= Pipelines::Guards::ShowGuard.new(current_user, merchant_id:)
      end

      def find_pipeline
        @find_pipeline ||= Pipelines::Operations::FindOperation
      end

      def pipeline_id
        @pipeline_id ||= params.fetch(:id)
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id, nil)
      end

      def present(pipeline)
        Pipelines::Presenters::ShowPresenter.new(pipeline, merchant_id:).serialize
      end
    end
  end
end
