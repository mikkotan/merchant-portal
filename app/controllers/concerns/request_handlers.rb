# frozen_string_literal: true

module RequestHandlers
  include Dry::Monads[:result]

  UNAUTHORIZED_MSG = 'Unauthorized request.'
  FORBIDDEN_MSG = 'Forbidden request.'
  INVALID_PARAMS_MSG = 'Invalid parameters.'
  NOT_FOUND_MSG = 'Resource not found.'

  private

  def handle_result(result, success_status = :ok)
    case result
    in Success(payload)
      handle_success(payload, success_status)
    in Failure(:invalid_params)
      handle_invalid_params
    in Failure(:unauthorized)
      handle_unauthorized_request
    in Failure(:forbidden)
      handle_forbidden_request
    in Failure(:not_found)
      handle_not_found
    else
      handle_bad_request
    end
  end

  def handle_success(payload, status = :ok)
    render json: payload, status:
  end

  def handle_invalid_params
    handle_bad_request(INVALID_PARAMS_MSG)
  end

  def handle_bad_request(errors = nil)
    render_error(errors, :bad_request)
  end

  def handle_unauthorized_request
    render_error(UNAUTHORIZED_MSG, :unauthorized)
  end

  def handle_forbidden_request
    render_error(FORBIDDEN_MSG, :forbidden)
  end

  def handle_not_found
    render_error(NOT_FOUND_MSG, :not_found)
  end

  def render_error(payload, status = :bad_request)
    render json: { error: payload }, status:
  end
end
