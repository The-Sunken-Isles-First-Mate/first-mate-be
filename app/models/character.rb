class Character < ApplicationRecord
  belongs_to :user
  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns
  has_one_attached :character_image

  validates_presence_of :name, :dnd_race, :dnd_class, :user_id

  def character_image
    return unless object.image.attached?
      object.image.blob.attributes
        .slice('filename', 'byte_size', 'id')
        .merge(url: character_image_url(object.image))
  end

  def character_image_url(image)
    rails_blob_path(image, only_path: true)
  end
end
