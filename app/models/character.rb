class Character < ApplicationRecord
  belongs_to :user
  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns

  validates_presence_of :name, :dnd_race, :dnd_class, :user_id
end
