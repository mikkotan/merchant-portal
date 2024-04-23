# frozen_string_literal: true

module Api
  module V1
    class PartnersController < ApiController
      def index
        result = Partners::Endpoints::ListEndpoint.call(request)
        handle_result(result)
      end

      def show
        result = Partners::Endpoints::ShowEndpoint.call(request)
        handle_result(result)
      end
    end
  end
end
