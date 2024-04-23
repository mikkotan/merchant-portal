# frozen_string_literal: true

class Pipeline < ApplicationRecord
  belongs_to :partner, foreign_key: :financial_institution_id
  belongs_to :merchant

  validates :partner, :merchant, presence: true
  validates :partner, uniqueness: { scope: :merchant_id }

  # TODO: Move to business logic domain validation
  validate :ensure_partner_stage_is_valid

  enum status: { pending: 0, active: 10, archived: 20 }, _prefix: true

  private

  def ensure_partner_stage_is_valid
    return if partner.present? && partner.stage_live?

    errors.add(:partner, 'must be in the live stage')
  end
end
