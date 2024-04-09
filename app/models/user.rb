# frozen_string_literal: true

class User < ApplicationRecord
  def external?
    type == 'ExternalUser'
  end

  def internal?
    type == 'InternalUser'
  end
end
