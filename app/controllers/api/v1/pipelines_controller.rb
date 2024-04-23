# frozen_string_literal: true

module Api
  module V1
    class PipelinesController < ApiController
      def create
        result = Pipelines::Endpoints::CreateEndpoint.call(request)
        handle_result(result, :created)
      end
    end
  end
end
