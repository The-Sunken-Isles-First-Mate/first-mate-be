class UserCampaign < ApplicationRecord
  enum :role, [:party_member, :dm], validate: true

  belongs_to :campaign
  belongs_to :user
  belongs_to :character, optional: true

  validates :campaign_id, :user_id, :role, presence: true
end
