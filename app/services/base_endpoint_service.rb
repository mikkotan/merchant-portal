# frozen_string_literal: true

class BaseEndpointService < BaseService
  def initialize(request)
    @request = request
    @current_user = nil
  end

  def call
    yield authenticate_request
    yield authorize_request if authorize_request.present?

    process
  end

  private

  attr_reader :request, :current_user

  def process
    raise NotImplementedError
  end

  def validate_params
    raise NotImplementedError
  end

  def query_params
    @query_params ||= yield validate_params
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

  def authorize_request
    nil
  end
end
