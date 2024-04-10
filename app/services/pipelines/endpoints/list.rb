# frozen_string_literal: true

module Pipelines
  module Endpoints
    class List < BaseEndpointService
      private

      def process
        pipelines = yield list_pipelines.call(query_params)

        Success(pipelines)
      end

      def list_pipelines
        @list_pipelines ||= Pipelines::Operations::List
      end

      def validate_params
        res = Try[ActionController::ParameterMissing] do
          params.require(%i[user_id merchant_id])
          params.permit(:user_id, :merchant_id, :active)
        end

        res.error? ? Failure(:invalid_params) : res
      end

      def authorize_request
        return Success(user_id) if current_user.internal?
        return Failure(:forbidden) unless user_id == current_user.id

        Success(user_id)
      end

      def user_id
        @user_id ||= query_params.fetch(:user_id)
      end

      def merchant_id
        @merchant_id ||= query_params.fetch(:merchant_id)
      end
    end
  end
end
