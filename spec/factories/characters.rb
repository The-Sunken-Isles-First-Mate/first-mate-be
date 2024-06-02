FactoryBot.define do
  factory :character do 
    association :user
    name { Faker::Lorem.word }
    dnd_race { "human" }
    dnd_class { "bard" }
    image_url { nil }
  end
end