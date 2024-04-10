# frozen_string_literal: true

module Pipelines
  module Presenters
    class ListPresenter
      def initialize(pipelines, options = {})
        @pipelines = pipelines
        @options = options
      end

      def serialize
        @pipelines.map do |pipeline|
          {
            id: pipeline.id,
            name: pipeline.name,
            about: pipeline.about,
            founded_in: pipeline.founded_in,
            active: pipeline.active_for?(merchant_id),
            stage: pipeline.stage,
            categories: pipeline.categories,
            company_website: pipeline.company_website
          }
        end
      end

      private

      def merchant_id
        @merchant_id ||= options.fetch(:merchant_id, nil)
      end

      attr_reader :pipelines, :options
    end
  end
end
