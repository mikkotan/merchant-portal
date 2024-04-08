# frozen_string_literal: true

require 'dry-monads'

class ApiController < ActionController::Api
  include Dry::Monads[:do]
  include RequestHandlers

  before_action :underscore_params!

  private

  attr_reader :current_user

  def authenticate_user
    result = AuthenticationService.call(request.headers)
    return handle_unauthorized_request unless result.success?

    @current_user = result.value!
  end

  def underscore_params!
    params.deep_transform_keys!(&:underscore)
  end
end
