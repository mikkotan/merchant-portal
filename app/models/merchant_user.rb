# frozen_string_literal: true

class MerchantUser < ApplicationRecord
  belongs_to :merchant
  belongs_to :external_user, foreign_key: :user_id

  validates :merchant, :external_user, presence: true
  validates :external_user, uniqueness: { scope: :merchant_id }
end
