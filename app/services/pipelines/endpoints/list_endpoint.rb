# frozen_string_literal: true

module Pipelines
  module Endpoints
    class ListEndpoint < BaseEndpointService
      private

      def process
        pipelines = yield list_pipelines.call(list_params)

        Success({ data: present(pipelines) })
      end

      def validate_params
        res = Try[ActionController::ParameterMissing] do
          params.require(%i[user_id merchant_id])
          params.permit(:user_id, :merchant_id, :active)
        end

        res.error? ? Failure(:invalid_params) : res
      end

      def guard
        @guard ||= Pipelines::Guards::ListGuard.new(current_user, user_id:, merchant_id:)
      end

      def user_id
        @user_id ||= query_params.fetch(:user_id)
      end

      def merchant_id
        @merchant_id ||= query_params.fetch(:merchant_id)
      end

      def list_pipelines
        @list_pipelines ||= Pipelines::Operations::ListOperation
      end

      def list_params
        query_params.merge(stage_params)
      end

      def stage_params
        {
          stage: Pipeline::STAGES_FOR[current_user.type]
        }
      end

      def present(pipelines)
        Pipelines::Presenters::ListPresenter.new(pipelines, merchant_id:).serialize
      end
    end
  end
end
