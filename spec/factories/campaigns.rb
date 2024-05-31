FactoryBot.define do
  factory :campaign do 
    name { Faker::Lorem.words(number: 2) }
    week { Faker::Number.between(from: 0, to: 10) }
    animal_products { Faker::Number.between(from: 0, to: 10) }
    cloth { Faker::Number.between(from: 0, to: 10) }
    farmed_goods { Faker::Number.between(from: 0, to: 10) }
    food { Faker::Number.between(from: 0, to: 10) }
    foraged_goods { Faker::Number.between(from: 0, to: 10) }
    metal { Faker::Number.between(from: 0, to: 10) }
    monster_parts { Faker::Number.between(from: 0, to: 10) }
    stone { Faker::Number.between(from: 0, to: 10) }
    wood { Faker::Number.between(from: 0, to: 10) }
    villagers { Faker::Number.between(from: 100, to: 200) }
  end
end