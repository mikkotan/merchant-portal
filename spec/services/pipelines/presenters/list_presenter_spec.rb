# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pipelines::Presenters::ListPresenter do
  describe '.serialize' do
    subject { described_class.new(pipelines, merchant_id:).serialize }

    let(:pipeline) { create(:pipeline) }
    let(:pipelines) { [pipeline] }
    let(:merchant) { create(:merchant) }
    let(:merchant_id) { merchant.id }

    it 'returns serialized pipelines' do
      subject.each do |pipeline|
        expect(pipeline.keys).to match_array(%i[id name about founded_in active stage categories
                                                company_website])
      end
    end
  end
end
