class CampaignItem < ApplicationRecord
  belongs_to :campaign
  belongs_to :item

  validates :campaign_id, :item_id, presence: true
  validates :quantity_owned, presence: true, numericality: true
end
