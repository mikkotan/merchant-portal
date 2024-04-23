# frozen_string_literal: true

module Partners
  module Presenters
    class ShowPresenter
      def initialize(partner, options = {})
        @partner = partner
        @options = options
      end

      def serialize
        base_fields.merge(active_field)
      end

      private

      attr_reader :partner, :options

      def base_fields
        {
          id: partner.id,
          name: partner.name,
          about: partner.about,
          founded_in: partner.founded_in,
          stage: partner.stage,
          categories: partner.categories.map(&:humanize),
          company_website: partner.company_website
        }
      end

      def active_field
        return {} unless merchant_id.present?

        { active: partner.active_for?(merchant_id) }
      end

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil)
      end
    end
  end
end
