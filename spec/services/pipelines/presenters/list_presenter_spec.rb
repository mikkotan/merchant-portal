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
      expect(subject).to eq(
        [
          {
            id: pipeline.id,
            name: pipeline.name,
            about: pipeline.about,
            founded_in: pipeline.founded_in,
            active: false,
            stage: pipeline.stage,
            categories: pipeline.categories,
            company_website: pipeline.company_website
          }
        ]
      )
    end
  end
end
