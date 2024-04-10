# frozen_string_literal: true

module Merchants
  module Endpoints
    class List < BaseEndpointService
      private

      def process
        merchants = yield list_merchants.call(query_params)

        Success({ data: present(merchants) })
      end

      def user_id
        @user_id ||= query_params.fetch(:user_id)
      end

      def validate_params
        res = Try[ActionController::ParameterMissing] do
          params.require(:user_id)
          params.permit(:user_id)
        end

        res.error? ? Failure(:invalid_params) : res
      end

      def authorize_request
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
