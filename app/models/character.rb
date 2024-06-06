class Character < ApplicationRecord
  belongs_to :user
  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns
  has_one_attached :character_image

  validates_presence_of :name, :dnd_race, :dnd_class, :user_id

  # def character_image_details
  #   return unless self.character_image.attached?
  #     self.character_image.blob.attributes
  #       .slice('filename', 'byte_size', 'id')
  #       .merge(url: character_image_url(self.character_image))
  # end

  # def character_image_url(image)
  #   rails_blob_path(image, only_path: true)
  # end

  # def character_image_details
  #   return unless self.character_image.attached?

  #   self.character_image.blob.attributes
  #       .slice('filename', 'byte_size', 'id')
  #       .merge(url: character_image_url(self.character_image))
  # end

  def character_image_url(character_image)
    Rails.application.routes.url_helpers.rails_blob_path(character_image, only_path: true)
  end
end
