# frozen_string_literal: true

FactoryBot.define do
  factory :pipeline do
    association :partner
    association :merchant
    status { Pipeline.statuses[:active] }
  end
end
