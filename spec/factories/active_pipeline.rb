# frozen_string_literal: true

FactoryBot.define do
  factory :active_pipeline do
    association :pipeline
    association :merchant
  end
end
