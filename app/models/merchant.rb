# frozen_string_literal: true

class Merchant < ApplicationRecord
  has_many :active_pipelines, foreign_key: :financial_institution_id
  has_many :merchant_users

  scope :by_user_id, ->(user_id) { joins(:merchant_users).where(merchant_users: { user_id: }) }
end
