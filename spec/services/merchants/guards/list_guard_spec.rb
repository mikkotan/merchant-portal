# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchants::Guards::ListGuard do
  describe '.call' do
    subject { described_class.call(target_user, options) }

    let(:target_user) { create(:internal_user) }
    let(:option_user) { create(:external_user) }
    let(:options) { { user_id: option_user.id } }

    it { expect(subject).to be_success }

    context 'when target user is external' do
      let(:target_user) { option_user }

      it { expect(subject).to be_success }

      context 'when target user id is not equal to option user id' do
        let(:options) { { user_id: 0 } }

        it { expect(subject).to be_failure }
        it { expect(subject.failure).to eq(:forbidden) }
      end
    end
  end
end
