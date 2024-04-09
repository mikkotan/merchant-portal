# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < SecuredController
      def index
        result = Merchants::Endpoints::List.call(request)
        handle_result(result)
      end
    end
  end
end
