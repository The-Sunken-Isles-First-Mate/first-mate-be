class User < ApplicationRecord
  has_many :user_campaigns
  has_many :campaigns, through: :user_campaigns
  has_many :characters
  has_secure_password

  validates :uid, :username, presence: true
  validates :uid, uniqueness: true
end
