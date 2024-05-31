class CampaignSerializer
  include JSONAPI::Serializer
  attributes :name, 
             :week,
             :animal_products,
             :cloth,
             :farmed_goods,
             :food,
             :foraged_goods,
             :metal,
             :monster_parts,
             :stone,
             :wood,
             :villagers
end