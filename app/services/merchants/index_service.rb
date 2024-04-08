# frozen_string_literal: true

module Merchants
  class IndexService < BaseService
    def initialize(params)
      super
      @user_id = params.fetch(:user_id, nil)
    end

    def call
      return Failure(:invalid_params) unless user_id.present?

      merchants = Merchant.by_user_id(user_id)
      Success(merchants)
    end

    private

    attr_reader :user_id
  end
end
