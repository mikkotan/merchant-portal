# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ExternalUser, type: :model do
  describe 'associations' do
    it { should have_many(:merchant_users) }
  end
end
