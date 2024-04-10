# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < ApiController
      def index
        result = Merchants::Endpoints::ListEndpoint.call(request)
        handle_result(result)
      end
    end
  end
end
