# frozen_string_literal: true

module Merchants
  class IndexPresenter
    def initialize(merchants)
      @merchants = merchants
    end

    def serialize
      @merchants.map do |merchant|
        {
          id: merchant.id,
          name: merchant.name
        }
      end
    end

    private

    attr_reader :merchants
  end
end
