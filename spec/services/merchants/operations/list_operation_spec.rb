# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchants::Operations::ListOperation do
  describe '.call' do
    subject { described_class.call(params) }

    let(:params) { { user_id: } }
    let(:user) { create(:external_user) }
    let(:user_id) { user.id }
    let(:merchant) { create(:merchant) }

    context 'when there are merchants for user_id' do
      let!(:merchant_user) { create(:merchant_user, merchant:, external_user: user) }

      it 'returns success with list of merchants' do
        expect(subject).to be_success

        merchants = subject.value!
        expect(merchants).to be_a_kind_of(ActiveRecord::Relation)
        expect(merchants.size).to eq(1)
      end
    end

    context 'when there are no merchants for user_id' do
      it 'returns success with empty list' do
        expect(subject).to be_success
        expect(subject.value!.size).to eq(0)
      end
    end
  end
end
