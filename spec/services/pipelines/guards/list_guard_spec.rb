# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Guards::ListGuard do
  describe '.call' do
    subject { described_class.call(target_user, options) }

    let(:target_user) { create(:internal_user) }
    let(:option_user) { create(:external_user) }
    let(:merchant_user) { create(:merchant_user, external_user: option_user) }
    let(:options) { { user_id: option_user.id, merchant_id: merchant_user.merchant_id } }

    it { expect(subject).to be_success }

    context 'when target user is external' do
      let(:target_user) { option_user }

      it { expect(subject).to be_success }

      context 'when target user id is not equal to option user id' do
        let(:options) { super().merge(user_id: 0) }

        it { expect(subject).to be_failure }
        it { expect(subject.failure).to eq(:forbidden) }
      end

      context 'when merchant does not belong to target user' do
        let(:merchant_user) { create(:merchant_user) }

        it { expect(subject).to be_failure }
        it { expect(subject.failure).to eq(:forbidden) }
      end
    end
  end
end
