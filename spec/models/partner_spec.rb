# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partner, type: :model do
  describe 'associations' do
    it { should have_many(:pipelines).with_foreign_key(:financial_institution_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:company_website) }
    it { should validate_presence_of(:stage) }
    it { should define_enum_for(:stage) }

    describe '#ensure_categories_are_valid' do
      subject { build(:partner, categories:) }

      let(:categories) { %w[bank credit_cards] }

      it { expect(subject).to be_valid }

      context 'when categories are invalid' do
        let(:categories) { %w[invalid] }

        it { expect(subject).to be_invalid }
      end
    end
  end
end
