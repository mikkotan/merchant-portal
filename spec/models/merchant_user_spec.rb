# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::MerchantUser, type: :model do
  describe 'associations' do
    it { should belong_to(:merchant) }
    it { should belong_to(:external_user).with_foreign_key(:user_id) }
  end
end
