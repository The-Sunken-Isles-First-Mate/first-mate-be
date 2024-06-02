class Character < ApplicationRecord
  # belongs_to :user
  # belongs_to :user_campaign, through: user
  # belongs_to :campaign, through: :user_campaign
 
  validates_presence_of :name, :dnd_race, :dnd_class
end