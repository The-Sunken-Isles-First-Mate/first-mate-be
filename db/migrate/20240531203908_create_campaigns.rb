class CreateCampaigns < ActiveRecord::Migration[7.1]
  def change
    create_table :campaigns do |t|
      t.string :name
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
      t.integer :villagers, default: 120

      t.timestamps
    end
  end
end
