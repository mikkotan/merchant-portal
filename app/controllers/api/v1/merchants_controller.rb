# frozen_string_literal: true

module Api
  module V1
    class MerchantsController < SecuredController
      def index
        merchants = Merchants::ListService.call(query_params)

        render json: { data: present_list(merchants) }
      end

      private

      def query_params
        params.permit(:user_id)
      end

      def present_list(merchants)
        Merchants::ListPresenter.new(merchants).serialize
      end
    end
  end
end
