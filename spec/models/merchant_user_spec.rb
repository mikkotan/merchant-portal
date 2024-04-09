# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MerchantUser, type: :model do
  describe 'associations' do
    it { should belong_to(:merchant) }
    it { should belong_to(:external_user).with_foreign_key(:user_id) }
  end

  describe 'validations' do
    subject { build(:merchant_user) }

    it { should validate_presence_of(:merchant) }
    it { should validate_presence_of(:external_user) }
    it { should validate_uniqueness_of(:external_user).scoped_to(:merchant_id) }
  end
end
