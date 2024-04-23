# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Endpoints::ListEndpoint do
  describe '.call' do
    subject { described_class.call(request) }

    let(:request) do
      Struct.new(:params, :headers).new(params:, headers:)
    end

    let(:params) { { user_id: merchant_user.user_id, merchant_id: merchant_user.merchant_id } }
    let(:headers) { { 'access-token' => current_user.id } }

    let(:current_user) { create(:internal_user) }
    let(:merchant_user) { create(:merchant_user) }
    let(:partner) { create(:partner) }

    it { expect(subject).to be_success }

    context 'when there are missing params' do
      let(:params) { {} }

      it { expect(subject).to be_failure }
      it { expect(subject.failure).to eq(:invalid_params) }
    end
  end
end
