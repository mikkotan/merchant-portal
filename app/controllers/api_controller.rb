# frozen_string_literal: true

require 'dry-monads'

class ApiController < ApplicationController
  include Dry::Monads[:do]
  include RequestHandlers
end
