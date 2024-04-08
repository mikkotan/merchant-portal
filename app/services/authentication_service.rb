# frozen_string_literal: true

require 'dry-monads'

class AuthenticationService < BaseService
  include Dry::Monads[:result]

  ACCESS_TOKEN_HEADER_PARAM = 'access-token'

  def initialize(headers)
    super
    @headers = headers
  end

  def call
    return Failure unless user_id.present?
    return Failure unless user.present?

    Success(user)
  end

  private

  attr_reader :headers

  def user_id
    @user_id ||= headers[ACCESS_TOKEN_HEADER_PARAM]
  end

  def user
    @user ||= User.find_by(id: user_id)
  end
end
