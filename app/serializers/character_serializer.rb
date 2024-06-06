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

  attribute :character_image do |character|
    Rails.application.routes.url_helpers.rails_blob_url(character.character_image, only_path: true) if character.character_image.attached?
  end
end