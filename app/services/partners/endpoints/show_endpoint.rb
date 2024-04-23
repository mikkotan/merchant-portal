# frozen_string_literal: true

module Partners
  module Endpoints
    class ShowEndpoint < BaseEndpointService
      private

      def process
        partner = yield find_partner.call(partner_id)

        Success({ data: present(partner) })
      end

      def contract
        @contract ||= Partners::Contracts::ShowContract.new
      end

      def guard
        @guard ||= Partners::Guards::ShowGuard.new(current_user, merchant_id:)
      end

      def find_partner
        @find_partner ||= Partners::Operations::FindOperation
      end

      def partner_id
        @partner_id ||= params.fetch(:id)
      end

      def merchant_id
        @merchant_id ||= params.fetch(:merchant_id, nil)
      end

      def present(partner)
        Partners::Presenters::ShowPresenter.new(partner, merchant_id:).serialize
      end
    end
  end
end
