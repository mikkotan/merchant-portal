# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'associations' do
    it { should have_many(:pipelines).with_foreign_key(:financial_institution_id) }
    it { should have_many(:merchant_users) }
  end
end
