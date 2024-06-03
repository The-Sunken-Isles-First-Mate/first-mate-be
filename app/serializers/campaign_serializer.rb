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

  has_many :user_campaigns
  has_many :users, through: :user_campaigns
  has_many :characters, through: :user_campaigns
  has_many :campaign_items
  has_many :items, through: :campaign_items
end
