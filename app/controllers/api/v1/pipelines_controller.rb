# frozen_string_literal: true

module Api
  module V1
    class PipelinesController < ApiController
      def create
        result = Pipelines::Endpoints::CreateEndpoint.call(request)
        handle_result(result, :created)
      end

      def activate
        result = Pipelines::Endpoints::ActivateEndpoint.call(request)
        handle_result(result)
      end
    end
  end
end
