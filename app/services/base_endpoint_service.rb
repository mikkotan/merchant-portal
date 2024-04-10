# frozen_string_literal: true

class BaseEndpointService < BaseService
  def initialize(request)
    @request = request
    @current_user = nil
  end

  private

  attr_reader :request
  attr_accessor :current_user

  def params
    @params ||= ActionController::Parameters.new(request.params).deep_transform_keys(&:underscore)
  end

  def headers
    @headers ||= request.headers
  end

  def authenticate_request
    result = AuthenticationService.call(request.headers)
    return Failure(:unauthorized) unless result.success?

    @current_user = result.value! if result.success?
    Success(current_user)
  end
end
