# frozen_string_literal: true

class MerchantUser < ApplicationRecord
  belongs_to :merchant
  belongs_to :external_user, foreign_key: :user_id
end
