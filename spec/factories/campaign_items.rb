FactoryBot.define do
  factory :campaign_item do
    association :item
    association :campaign
    quantity_owned { Faker::Number.between(from: 0, to: 10) }
  end
end