class CharacterSerializer
  include Rails.application.routes.url_helpers
  include JSONAPI::Serializer
  attributes :name,
             :user_id,
             :dnd_race,
             :dnd_class,
             :image_url

  belongs_to :user
  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns
end
