# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Presenters::ShowPresenter do
  describe '#serialize' do
    subject { described_class.new(partner, options).serialize }

    let(:partner) { create(:partner) }
    let(:options) { {} }

    it { expect(subject.keys).to match_array(%i[id name about founded_in stage categories company_website]) }

    context 'when options include merchant_id' do
      let(:options) { { merchant_id: 'some-uuid' } }

      it { expect(subject.keys).to include(:active) }
    end
  end
end
