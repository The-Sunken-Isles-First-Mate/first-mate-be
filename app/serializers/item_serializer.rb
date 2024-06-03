class ItemSerializer
  include JSONAPI::Serializer
  attributes :name, 
             :animal_products_cost,
             :cloth_cost,
             :farmed_goods_cost,
             :food_cost,
             :foraged_goods_cost,
             :metal_cost,
             :stone_cost,
             :wood_cost,
             :monster_parts_cost
end