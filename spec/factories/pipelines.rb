# frozen_string_literal: true

FactoryBot.define do
  factory :pipeline do
    name { Faker::Company.name }
    about { Faker::Lorem.sentence }
    founded_in { Faker::Date.between(from: 10.years.ago, to: Date.today) }
    company_website { Faker::Internet.url }
    stage { Pipeline.stages[:live] }
    categories { ['other'] }
  end
end
