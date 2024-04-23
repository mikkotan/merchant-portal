# frozen_string_literal: true

module Pipelines
  module Endpoints
    class CreateEndpoint < BaseEndpointService
      private

      def process
        pipeline = yield create_pipeline.call(params)

        Success({ data: present(pipeline) })
      end

      def contract
        @contract ||= Pipelines::Contracts::CreateContract.new
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id)
      end

      def guard
        @guard ||= Pipelines::Guards::CreateGuard.new(current_user, merchant_id:)
      end

      def create_pipeline
        @create_pipeline ||= Pipelines::Operations::CreateOperation
      end

      def present(pipeline)
        Pipelines::Presenters::ShowPresenter.new(pipeline).serialize
      end
    end
  end
end
