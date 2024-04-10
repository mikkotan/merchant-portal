# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationService do
  describe '.call' do
    subject { described_class.call(params) }

    let(:params) { { 'access-token' => user.id } }
    let(:user) { create(:external_user) }

    it 'returns the user' do
      expect(subject).to be_success
      expect(subject.value!).to eq(user)
    end

    context 'when access token is missing' do
      let(:params) { {} }

      it 'returns failure' do
        expect(subject).to be_failure
        expect(subject.failure).to eq(:access_token_missing)
      end
    end

    context 'when user is not found' do
      let(:params) { { 'access-token' => 0 } }

      it 'returns failure' do
        expect(subject).to be_failure
        expect(subject.failure).to eq(:user_not_found)
      end
    end
  end
end
