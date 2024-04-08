# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ::Pipeline, type: :model do
  describe 'associations' do
    it { should have_many(:active_pipelines).with_foreign_key(:financial_institutions_id) }
  end
end