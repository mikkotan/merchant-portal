# frozen_string_literal: true

module Pipelines
  module Presenters
    class ShowPresenter
      def initialize(pipeline)
        @pipeline = pipeline
      end

      def serialize
        {
          id: pipeline.id,
          merchant_id: pipeline.merchant_id,
          financial_institution_id: pipeline.financial_institution_id,
          status: pipeline.status,
          partner: serialize_partner
        }
      end

      private

      attr_reader :pipeline

      def serialize_partner
        Partners::Presenters::ShowPresenter.new(pipeline.partner).serialize
      end
    end
  end
end
