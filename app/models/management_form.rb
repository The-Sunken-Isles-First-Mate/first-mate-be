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
  validate :valid_resource_fields, on: :update
  validate :valid_building_allocation, on: :update

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

  def valid_resource_fields
    resource_fields.each do |field, value|
      unless divisible_by_ten_or_zero?(value)
        errors.add(:base, "Villagers must be dispatched in groups of 10. Please try again.")
      end
    end
  end

  def divisible_by_ten_or_zero?(value)
    value == 0 || value % 10 == 0
  end

  def resource_fields
    { animal_products: animal_products,
      cloth: cloth,
      farmed_goods: farmed_goods,
      food: food,
      foraged_goods: foraged_goods,
      metal: metal,
      monster_parts: monster_parts,
      stone: stone,
      wood: wood
    }
  end

  def valid_building_allocation
    if building_allocation_count > 1
      errors.add(:base, "You cannot commission more than one building per week. Please try again.")
    end
  end

  def building_allocation_count
    magical_defenses + cabin + storage
  end
end
