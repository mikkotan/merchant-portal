# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < SecuredController
      def index
        merchants = Merchants::IndexService.call(query_params)

        render json: { data: present(merchants) }
      end

      private

      def query_params
        params.permit(:user_id)
      end

      def present(merchants)
        Merchants::IndexPresenter.new(merchants).serialize
      end
    end
  end
end
