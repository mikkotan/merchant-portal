# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pipelines::Operations::ListOperation do
  describe '.call' do
    subject { described_class.call(params) }

    let(:params) { { user_id:, merchant_id:, active: } }
    let(:merchant_user) { create(:merchant_user) }
    let(:user) { merchant_user.external_user }
    let(:merchant) { merchant_user.merchant }
    let(:user_id) { user.id }
    let(:merchant_id) { merchant.id }
    let(:active) { false }

    context 'when pipelines exists' do
      let!(:pipeline) { create(:pipeline) }

      it 'returns success with list of pipelines' do
        expect(subject).to be_success
        expect(subject.value!.size).to eq(1)
      end
    end

    context 'when pipelines does not exist' do
      it 'returns success with empty list' do
        expect(subject).to be_success
        expect(subject.value!.size).to eq(0)
      end
    end

    context 'when active is true' do
      let(:active) { true }

      context 'when active pipelines exists for merchant' do
        let!(:active_pipeline) { create(:active_pipeline, merchant:) }

        it 'returns success with list of active pipelines' do
          expect(subject).to be_success
          expect(subject.value!.size).to eq(1)
        end
      end

      context 'when active pipelines does not exist for merchant' do
        it 'returns success with empty list' do
          expect(subject).to be_success
          expect(subject.value!.size).to eq(0)
        end
      end
    end
  end
end
