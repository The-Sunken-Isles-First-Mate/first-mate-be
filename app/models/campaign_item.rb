class CampaignItem < ApplicationRecord
  belongs_to :campaign
  belongs_to :item

  validates :campaign_id, :item_id, :quantity_owned, presence: true
end