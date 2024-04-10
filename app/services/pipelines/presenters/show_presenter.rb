# frozen_string_literal: true

module Pipelines
  module Presenters
    class ShowPresenter
      def initialize(pipeline, options = {})
        @pipeline = pipeline
        @options = options
      end

      def serialize
        base_fields.merge(active_field)
      end

      private

      attr_reader :pipeline, :options

      def base_fields
        {
          id: pipeline.id,
          name: pipeline.name,
          about: pipeline.about,
          founded_in: pipeline.founded_in,
          stage: pipeline.stage,
          categories: pipeline.categories.map(&:humanize),
          company_website: pipeline.company_website
        }
      end

      def active_field
        return {} unless merchant_id.present?

        { active: pipeline.active_for?(merchant_id) }
      end

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil)
      end
    end
  end
end
