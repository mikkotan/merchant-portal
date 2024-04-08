# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ActivePipeline, type: :model do
  describe 'associations' do
    it { should belong_to(:pipeline).with_foreign_key(:financial_institutions_id) }
    it { should belong_to(:merchant) }
  end
end
