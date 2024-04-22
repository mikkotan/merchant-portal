# frozen_string_literal: true

class BaseEndpointService < BaseService
  def initialize(request)
    @request = request
    @current_user = nil
  end

  def call
    @query_params = yield validate_params if validate_params

    yield authenticate_request
    yield guard.call if guard.present?

    process
  end

  private

  attr_reader :request, :current_user, :query_params

  def process
    raise NotImplementedError
  end

  def validate_params
    nil
  end

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

  def guard
    nil
  end
end
