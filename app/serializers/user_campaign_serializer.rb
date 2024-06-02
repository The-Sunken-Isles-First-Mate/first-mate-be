class UserCampaignSerializer
  include JSONAPI::Serializer
  attributes :role

  belongs_to :user
  belongs_to :campaign
  belongs_to :character, optional: true
end
