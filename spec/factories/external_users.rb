# frozen_string_literal: true

FactoryBot.define do
  factory :external_user, parent: :user, class: ExternalUser
end
