# frozen_string_literal: true

module RequestHandlers
  include Dry::Monads[:result]

  STATEMENT_INVALID_MSG = 'Unable to save record due to database constraints.'

  private

  def handle_unauthorized_request
    render_error('Unauthorized request', :unauthorized)
  end

  def render_error(payload, status = :bad_request)
    render json: { error: payload }, status:
  end
end
