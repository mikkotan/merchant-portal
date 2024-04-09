# frozen_string_literal: true

FactoryBot.define do
  factory :merchant_user do
    association :external_user
    association :merchant
  end
end
