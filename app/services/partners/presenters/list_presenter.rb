# frozen_string_literal: true

module Partners
  module Presenters
    class ListPresenter
      def initialize(partners, options = {})
        @partners = partners
        @options = options
      end

      def serialize
        partners.map do |partner|
          Partners::Presenters::ShowPresenter.new(partner, merchant_id:).serialize
        end
      end

      private

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil)
      end

      attr_reader :partners, :options
    end
  end
end
