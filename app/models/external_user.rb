# frozen_string_literal: true

class ExternalUser < User
  has_many :merchant_users, foreign_key: :user_id
end
