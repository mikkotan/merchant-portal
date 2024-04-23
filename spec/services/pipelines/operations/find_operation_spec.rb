# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Operations::FindOperation do
  describe '.call' do
    subject { described_class.call(partner_id) }

    let(:partner) { create(:partner) }
    let(:partner_id) { partner.id }

    context 'when partner exists' do
      it { expect(subject).to be_success }
      it { expect(subject.value!.id).to eq(partner_id) }
    end

    context 'when partner does not exist' do
      let(:partner_id) { 'some-uuid' }

      it { expect(subject).to be_failure }
      it { expect(subject.failure).to eq(:not_found) }
    end
  end
end
