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

  has_many :campaign_items
  has_many :campaigns, through: :campaign_items
end
