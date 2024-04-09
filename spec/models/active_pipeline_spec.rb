# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActivePipeline, type: :model do
  subject { build(:active_pipeline, pipeline:) }

  let(:pipeline) { build(:pipeline, stage:) }
  let(:stage) { Pipeline.stages[:live] }

  describe 'associations' do
    it { should belong_to(:pipeline).with_foreign_key(:financial_institution_id) }
    it { should belong_to(:merchant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pipeline) }
    it { should validate_presence_of(:merchant) }
    it { should validate_uniqueness_of(:pipeline).scoped_to(:merchant_id) }

    describe '#ensure_pipeline_stage_is_valid' do
      it { expect(subject).to be_valid }

      context 'when pipeline stage is not live' do
        let(:stage) { Pipeline.stages[:contracting] }

        it { expect(subject).to be_invalid }
      end
    end
  end
end
