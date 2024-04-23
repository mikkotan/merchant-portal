# frozen_string_literal: true

module Pipelines
  module Guards
    class ActivateGuard < BaseGuard
      def call
        return Success(true) if target_user.internal?

        Failure(:forbidden)
      end
    end
  end
end
