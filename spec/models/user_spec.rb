# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#external?' do
    subject { user.external? }

    let(:user) { build(:external_user) }

    it { is_expected.to be_truthy }

    context 'when user is internal' do
      let(:user) { build(:internal_user) }

      it { is_expected.to be_falsey }
    end
  end

  describe '#internal?' do
    subject { user.internal? }

    let(:user) { build(:internal_user) }

    it { is_expected.to be_truthy }

    context 'when user is external' do
      let(:user) { build(:external_user) }

      it { is_expected.to be_falsey }
    end
  end
end
