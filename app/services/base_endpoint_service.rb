# frozen_string_literal: true

class BaseEndpointService < BaseService
  def initialize(request)
    @request = request
    @current_user = nil
  end

  def call
    @params = yield apply_contract if contract.present?

    yield authenticate_request
    yield guard.call if guard.present?

    process
  end

  private

  attr_reader :request, :current_user, :params

  def process
    raise NotImplementedError
  end

  def dirty_params
    @dirty_params ||= ActionController::Parameters.new(request.params).deep_transform_keys(&:underscore)
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

  def contract
    nil
  end

  def apply_contract
    result = contract.call(dirty_params.to_unsafe_h)

    if result.success?
      Success(result.to_h)
    else
      Failure(:invalid_params)
    end
  end
end
