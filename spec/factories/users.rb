FactoryBot.define do
  factory :user do
    uid { Faker::Alphanumeric.alphanumeric(number: 5) }
    username { Faker::Internet.username(specifier: 5..8) }
    token { Faker::Alphanumeric.alphanumeric(number: 20) }
  end
end
