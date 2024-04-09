# frozen_string_literal: true

class Pipeline < ApplicationRecord
  self.table_name = :financial_institutions

  CATEGORIES = %w[bank credit_cards wealth_management investments others].freeze

  has_many :active_pipelines, foreign_key: :financial_institution_id

  enum stage: {
    contracting: 0,
    implementation: 10,
    live: 20
  }, _prefix: true

  validates :name, :company_website, :stage, presence: true
  validate :ensure_categories_are_valid

  private

  def ensure_categories_are_valid
    return if (categories - CATEGORIES).empty?

    errors.add(:categories, 'must be valid')
  end
end
