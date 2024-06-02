class Campaign < ApplicationRecord
 has_many :items  
 
 validates :name, :week, :animal_products, :cloth, :farmed_goods, 
            :food, :foraged_goods, :metal, :monster_parts, :stone, 
            :wood, :villagers, presence: true

  validates :week, :animal_products, :cloth, :farmed_goods, :food, 
            :foraged_goods, :metal, :monster_parts, :stone, :wood, 
            :villagers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end