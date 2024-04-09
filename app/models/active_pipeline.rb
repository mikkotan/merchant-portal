# frozen_string_literal: true

class ActivePipeline < ApplicationRecord
  belongs_to :pipeline, foreign_key: :financial_institution_id
  belongs_to :merchant

  validates :pipeline, :merchant, presence: true
  validates :pipeline, uniqueness: { scope: :merchant_id }

  # TODO: Move to business logic domain validation
  validate :ensure_pipeline_stage_is_valid

  private

  def ensure_pipeline_stage_is_valid
    return if pipeline.present? && pipeline.stage_live?

    errors.add(:pipeline, 'must be in the live stage')
  end
end
