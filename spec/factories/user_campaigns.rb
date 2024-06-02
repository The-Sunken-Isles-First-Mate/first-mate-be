FactoryBot.define do
  factory :user_campaign do
    role { 0 }
    association :user
    association :campaign
    association :character
  end
end
