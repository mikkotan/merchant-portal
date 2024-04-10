# frozen_string_literal: true

class Pipeline < ApplicationRecord
  self.table_name = :financial_institutions

  CATEGORIES = %w[bank credit_cards wealth_management investments other].freeze

  has_many :active_pipelines, foreign_key: :financial_institution_id

  enum stage: {
    contracting: 0,
    implementation: 10,
    live: 20
  }, _prefix: true

  validates :name, :company_website, :stage, presence: true
  validate :ensure_categories_are_valid

  scope :active, lambda { |merchant_id, user_id|
    joins(active_pipelines: { merchant: :merchant_users })
      .where(active_pipelines: { merchant_id: })
      .where(merchant_users: { user_id: })
  }

  def active_for?(merchant_id)
    active_pipelines.exists?(merchant_id:)
  end

  private

  def ensure_categories_are_valid
    return if (categories - CATEGORIES).empty?

    errors.add(:categories, 'must be valid')
  end
end
