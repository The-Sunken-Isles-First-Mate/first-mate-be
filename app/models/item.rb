class Item < ApplicationRecord
  has_many :campaign_items, dependent: :delete_all
  has_many :campaigns, through: :campaign_items, dependent: :delete_all
end