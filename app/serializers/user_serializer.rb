class UserSerializer
  include JSONAPI::Serializer
  attributes :uid, :username

  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns
  has_many :characters
end
