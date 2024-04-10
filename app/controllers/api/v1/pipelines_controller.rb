# frozen_string_literal: true

module Api
  module V1
    class PipelinesController < ApiController
      def index
        result = Pipelines::Endpoints::ListEndpoint.call(request)
        handle_result(result)
      end
    end
  end
end
