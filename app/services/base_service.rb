# frozen_string_literal: true

require 'dry-monads'

class BaseService
  include Dry::Monads[:result, :do, :try]

  class << self
    def call(*)
      new(*).call
    end
  end
end
