# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchants::Presenters::ListPresenter do
  describe '.serialize' do
    subject { described_class.new(merchants).serialize }

    let(:merchant) { create(:merchant) }
    let(:merchants) { [merchant] }

    it 'returns serialized merchants' do
      expect(subject).to eq(
        [
          {
            id: merchant.id,
            name: merchant.name
          }
        ]
      )
    end
  end
end
