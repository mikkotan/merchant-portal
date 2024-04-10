# frozen_string_literal: true

module Merchants
  module Endpoints
    class List < BaseEndpointService
      def initialize(request)
        @request = request
      end

      def call
        query_params = yield validate_params

        yield authenticate_request
        yield merchant_user_authorized?(query_params[:user_id])

        merchants = yield list_merchants.call(query_params)

        Success({ data: present(merchants) })
      end

      private

      attr_reader :request

      def validate_params
        res = Try[ActionController::ParameterMissing] do
          params.require(:user_id)
          params.permit(:user_id)
        end

        res.error? ? Failure(:invalid_params) : res
      end

      def contract
        @contract ||= Merchants::Contracts::ListContract.new
      end

      def merchant_user_authorized?(user_id)
        return Success(user_id) if current_user.internal?
        return Failure(:forbidden) unless user_id == current_user.id

        Success(user_id)
      end

      def list_merchants
        @list_merchants ||= Merchants::Operations::List
      end

      def present(merchants)
        Merchants::Presenters::ListPresenter.new(merchants).serialize
      end
    end
  end
end
