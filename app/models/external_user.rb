# frozen_string_literal: true

# ExternalUser is a subclass of User
class ExternalUser < User
  has_many :merchant_users, foreign_key: :user_id
end
