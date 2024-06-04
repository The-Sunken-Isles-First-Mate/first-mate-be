class CampaignItemSerializer
  include JSONAPI::Serializer
  attributes :campaign_id,
             :item_id,
             :quantity_owned

  belongs_to :campaign
  belongs_to :item
end
