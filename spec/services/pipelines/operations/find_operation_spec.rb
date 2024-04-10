# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pipelines::Operations::FindOperation do
  describe '.call' do
    subject { described_class.call(pipeline_id) }

    let(:pipeline) { create(:pipeline) }
    let(:pipeline_id) { pipeline.id }

    context 'when pipeline exists' do
      it { expect(subject).to be_success }
      it { expect(subject.value!.id).to eq(pipeline_id) }
    end

    context 'when pipeline does not exist' do
      let(:pipeline_id) { 'some-uuid' }

      it { expect(subject).to be_failure }
      it { expect(subject.failure).to eq(:not_found) }
    end
  end
end
