# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pipeline, type: :model do
  subject { build(:pipeline, partner:) }

  let(:partner) { build(:partner, stage:) }
  let(:stage) { Partner.stages[:live] }

  describe 'associations' do
    it { should belong_to(:partner).with_foreign_key(:financial_institution_id) }
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:partner) }
    it { should validate_presence_of(:merchant) }
    it { should validate_uniqueness_of(:partner).scoped_to(:merchant_id) }

    describe '#ensure_partner_stage_is_valid' do
      it { expect(subject).to be_valid }

      context 'when partner stage is not live' do
        let(:stage) { Partner.stages[:contracting] }

        it { expect(subject).to be_invalid }
      end
    end
  end
end
