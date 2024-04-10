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
          Pipelines::Presenters::ShowPresenter.new(pipeline, merchant_id:).serialize
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
