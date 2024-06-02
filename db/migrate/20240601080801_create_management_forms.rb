class CreateManagementForms < ActiveRecord::Migration[7.1]
  def change
    create_table :management_forms do |t|
      t.references :campaign, null: false, foreign_key: true
      t.integer :week, default: 0
      t.integer :animal_products, default: 0
      t.integer :cloth, default: 0
      t.integer :farmed_goods, default: 0
      t.integer :food, default: 0
      t.integer :foraged_goods, default: 0
      t.integer :metal, default: 0
      t.integer :monster_parts, default: 0
      t.integer :stone, default: 0
      t.integer :wood, default: 0
      t.integer :light_armor, default: 0
      t.integer :medium_armor, default: 0
      t.integer :heavy_armor, default: 0
      t.integer :simple_weapon, default: 0
      t.integer :martial_weapon, default: 0
      t.integer :ammunition, default: 0
      t.integer :adventuring_supplies, default: 0
      t.integer :assassins_blood, default: 0
      t.integer :malice, default: 0
      t.integer :midnight_tears, default: 0
      t.integer :serpent_venom, default: 0
      t.integer :truth_serum, default: 0
      t.integer :oil_of_slipperiness, default: 0
      t.integer :potion_of_climbing, default: 0
      t.integer :potion_of_healing, default: 0
      t.integer :potion_of_water_breathing, default: 0
      t.integer :barge, default: 0
      t.integer :coracle, default: 0
      t.integer :double_hulled_sailing_canoe, default: 0
      t.integer :keelboat, default: 0
      t.integer :raft, default: 0
      t.integer :single_hulled_sailing_canoe, default: 0
      t.integer :ballista, default: 0
      t.integer :cabin, default: 0
      t.integer :magical_defenses, default: 0
      t.integer :storage, default: 0

      t.timestamps
    end
  end
end
