# frozen_string_literal: true

module Partners
  module Endpoints
    class ListEndpoint < BaseEndpointService
      private

      def process
        partners = yield list_partners.call(list_params)

        Success({ data: present(partners) })
      end

      def validate_params
        res = Try[ActionController::ParameterMissing] do
          params.require(%i[user_id merchant_id])
          params.permit(:user_id, :merchant_id, :active)
        end

        res.error? ? Failure(:invalid_params) : res
      end

      def guard
        @guard ||= Partners::Guards::ListGuard.new(current_user, user_id:, merchant_id:)
      end

      def user_id
        @user_id ||= query_params.fetch(:user_id)
      end

      def merchant_id
        @merchant_id ||= query_params.fetch(:merchant_id)
      end

      def list_partners
        @list_partners ||= Partners::Operations::ListOperation
      end

      def list_params
        query_params.merge(stage_params)
      end

      def stage_params
        {
          stage: Partner::STAGES_FOR[current_user.type]
        }
      end

      def present(partners)
        Partners::Presenters::ListPresenter.new(partners, merchant_id:).serialize
      end
    end
  end
end
