class User < ApplicationRecord
  # has_many :user_campaigns
  # has_many :campaigns, through: :user_campaigns
  # has_many :characters

  validates :uid, :username, :token, presence: true
  validates :uid, uniqueness: true
end
