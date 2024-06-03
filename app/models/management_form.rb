class ManagementForm < ApplicationRecord
  belongs_to :campaign

  validates :campaign_id, :week, :animal_products, :cloth, :farmed_goods,
            :food, :foraged_goods, :metal, :monster_parts, :stone,
            :wood, :light_armor, :medium_armor, :heavy_armor, :simple_weapon,
            :martial_weapon, :ammunition, :adventuring_supplies, :assassins_blood,
            :malice, :midnight_tears, :serpent_venom, :truth_serum, :oil_of_slipperiness,
            :potion_of_climbing, :potion_of_healing, :potion_of_water_breathing,
            :barge, :coracle, :double_hulled_sailing_canoe, :keelboat, :raft,
            :single_hulled_sailing_canoe, :ballista, :cabin, :magical_defenses, :storage, 
            presence: true

  validates :campaign_id, :week, :animal_products, :cloth, :farmed_goods, :food,
            :foraged_goods, :metal, :monster_parts, :stone, :wood,
            :light_armor, :medium_armor, :heavy_armor, :simple_weapon,
            :martial_weapon, :ammunition, :adventuring_supplies, :assassins_blood,
            :malice, :midnight_tears, :serpent_venom, :truth_serum, :oil_of_slipperiness,
            :potion_of_climbing, :potion_of_healing, :potion_of_water_breathing,
            :barge, :coracle, :double_hulled_sailing_canoe, :keelboat, :raft,
            :single_hulled_sailing_canoe, :ballista, :cabin, :magical_defenses, :storage,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :valid_villager_distribution, on: :update

  private
  def valid_villager_distribution
    campaign = Campaign.find_by(id: campaign_id)
    if campaign.villagers < villager_distribution_count
      errors.add(:base, "You cannot allocate more than #{campaign.villagers} villagers to collect resources. Please try again.")
    end
  end

  def villager_distribution_count
    animal_products + cloth + farmed_goods + food + foraged_goods + metal + monster_parts + stone + wood
  end
end
