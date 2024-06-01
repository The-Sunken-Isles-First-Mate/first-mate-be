FactoryBot.define do
  factory :campaign do 
    name { Faker::Lorem.word }
    week { 0 }
    animal_products { 0 }
    cloth { 0 }
    farmed_goods { 0 }
    food { 0 }
    foraged_goods { 0 }
    metal { 0 }
    monster_parts { 0 }
    stone { 0 }
    wood { 0 }
    villagers { 120 }
  end
end