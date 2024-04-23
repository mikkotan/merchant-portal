# frozen_string_literal: true

FactoryBot.define do
  factory :partner do
    name { Faker::Company.name }
    about { Faker::Lorem.sentence }
    founded_in { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    company_website { Faker::Internet.url }
    stage { Partner.stages[:live] }
    categories { ['other'] }
  end
end
