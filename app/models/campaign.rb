class Campaign < ApplicationRecord
  has_many :user_campaigns
  has_many :users, through: :user_campaigns
  has_many :characters, through: :user_campaigns
  has_many :campaign_items
  has_many :items, through: :campaign_items
  has_many :management_forms

  validates :name, :week, :animal_products, :cloth, :farmed_goods,
            :food, :foraged_goods, :metal, :monster_parts, :stone,
            :wood, :villagers, presence: true

  validates :week, :animal_products, :cloth, :farmed_goods, :food,
            :foraged_goods, :metal, :monster_parts, :stone, :wood,
            :villagers, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_create :create_campaign_items
  after_create :create_management_form

  private
  def create_campaign_items
    Item.find_each do |item|
      self.campaign_items.create!(item: item)
    end
  end

  def create_management_form
    self.management_forms.create!
  end
end
