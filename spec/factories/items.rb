FactoryBot.define do
  factory :item do 
    name { Faker::Lorem.words(number: 2) }
    animal_products_cost { Faker::Number.between(from: 0, to: 10) }
    cloth_cost { Faker::Number.between(from: 0, to: 10) }
    farmed_goods_cost { Faker::Number.between(from: 0, to: 10) }
    food_cost { Faker::Number.between(from: 0, to: 10) }
    foraged_goods_cost { Faker::Number.between(from: 0, to: 10) }
    metal_cost { Faker::Number.between(from: 0, to: 10) }
    stone_cost { Faker::Number.between(from: 0, to: 10) }
    wood_cost { Faker::Number.between(from: 0, to: 10) }
  end
end