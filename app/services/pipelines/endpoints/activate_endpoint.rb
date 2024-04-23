# frozen_string_literal: true

module Pipelines
  module Endpoints
    class ActivateEndpoint < BaseEndpointService
      private

      def process
        pipeline = yield find_pipeline
        yield activate_pipeline(pipeline)

        Success({ data: present(pipeline) })
      end

      def contract
        @contract ||= Pipelines::Contracts::ActivateContract.new
      end

      def guard
        @guard ||= Pipelines::Guards::ActivateGuard.new(current_user)
      end

      def pipeline_id
        @pipeline_id ||= params.fetch(:id)
      end

      def find_pipeline
        @find_pipeline ||= Pipelines::Operations::FindOperation.call(pipeline_id)
      end

      def activate_pipeline(pipeline)
        result = Pipelines::Operations::ActivateOperation.call(pipeline)
        return Success(pipeline) if result.success?

        Failure([:unprocessable_entity, result.failure])
      end

      def present(pipeline)
        Pipelines::Presenters::ShowPresenter.new(pipeline).serialize
      end
    end
  end
end
