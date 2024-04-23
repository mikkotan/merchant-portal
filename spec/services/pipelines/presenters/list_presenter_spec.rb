# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Presenters::ListPresenter do
  describe '.serialize' do
    subject { described_class.new(partners, merchant_id:).serialize }

    let(:partner) { create(:partner) }
    let(:partners) { [partner] }
    let(:merchant) { create(:merchant) }
    let(:merchant_id) { merchant.id }

    it 'returns serialized partners' do
      subject.each do |partner|
        expect(partner.keys).to match_array(%i[id name about founded_in active stage categories
                                               company_website])
      end
    end
  end
end
