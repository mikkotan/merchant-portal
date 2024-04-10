# frozen_string_literal: true

class BaseGuard < BaseService
  def initialize(target_user, options = {})
    @target_user = target_user
    @options = options
  end

  private

  attr_reader :target_user, :options
end
