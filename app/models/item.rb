class Item < ApplicationRecord
  has_many :campaign_items
  has_many :campaigns, through: :campaign_items
end