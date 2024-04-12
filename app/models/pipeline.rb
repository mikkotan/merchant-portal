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

  STAGES_FOR = {
    'InternalUser' => stages.values,
    'ExternalUser' => stages.values_at('live')
  }.freeze

  validates :name, :company_website, :stage, presence: true
  validate :ensure_categories_are_valid

  scope :active, ->(merchant_id) { joins(:active_pipelines).where(active_pipelines: { merchant_id: }) }
  scope :by_stage, ->(stage) { where(stage:) }

  def active_for?(merchant_id)
    active_pipelines.exists?(merchant_id:)
  end

  private

  def ensure_categories_are_valid
    return if (categories - CATEGORIES).empty?

    errors.add(:categories, 'must be valid')
  end
end
