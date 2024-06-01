FactoryBot.define do
  factory :management_form do
    association :campaign
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
    light_armor { Faker::Number.between(from: 0, to: 10) }
    medium_armor { Faker::Number.between(from: 0, to: 10) }
    heavy_armor { Faker::Number.between(from: 0, to: 10) }
    simple_weapon { Faker::Number.between(from: 0, to: 10) }
    martial_weapon { Faker::Number.between(from: 0, to: 10) }
    ammunition { Faker::Number.between(from: 0, to: 10) }
    adventuring_supplies { Faker::Number.between(from: 0, to: 10) }
    assassins_blood { Faker::Number.between(from: 0, to: 10) }
    malice { Faker::Number.between(from: 0, to: 10) }
    midnight_tears { Faker::Number.between(from: 0, to: 10) }
    serpent_venom { Faker::Number.between(from: 0, to: 10) }
    truth_serum { Faker::Number.between(from: 0, to: 10) }
    oil_of_slipperiness { Faker::Number.between(from: 0, to: 10) }
    potion_of_climbing { Faker::Number.between(from: 0, to: 10) }
    potion_of_healing { Faker::Number.between(from: 0, to: 10) }
    potion_of_water_breathing { Faker::Number.between(from: 0, to: 10) }
    barge { Faker::Number.between(from: 0, to: 10) }
    coracle { Faker::Number.between(from: 0, to: 10) }
    double_hulled_sailing_canoe { Faker::Number.between(from: 0, to: 10) }
    keelboat { Faker::Number.between(from: 0, to: 10) }
    raft { Faker::Number.between(from: 0, to: 10) }
    single_hulled_sailing_canoe { Faker::Number.between(from: 0, to: 10) }
    ballista { Faker::Number.between(from: 0, to: 10) }
    cabin { Faker::Number.between(from: 0, to: 10) }
    magical_defenses { Faker::Number.between(from: 0, to: 10) }
    storage { Faker::Number.between(from: 0, to: 10) }
  end
end
