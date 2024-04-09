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
    @params ||= ActionController::Parameters.new(request.params)
  end

  def headers
    @headers ||= request.headers
  end

  def authenticate_request
    result = AuthenticationService.call(request.headers)
    @current_user = result.success! if result.success?

    Failure(:unauthorized)
  end
end
