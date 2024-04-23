# frozen_string_literal: true

module Partners
  module Operations
    class FindOperation < BaseService
      def initialize(partner_id)
        @partner_id = partner_id
      end

      def call
        partner = Partner.find_by(id: partner_id)
        return Success(partner) if partner.present?

        Failure(:not_found)
      end

      private

      attr_reader :partner_id
    end
  end
end
