# frozen_string_literal: true

require 'dry-monads'

module Merchants
  class ListService < BaseService
    include Dry::Monads[:result]

    def initialize(params)
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
