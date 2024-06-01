class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :animal_products_cost
      t.integer :cloth_cost
      t.integer :farmed_goods_cost
      t.integer :food_cost
      t.integer :foraged_goods_cost
      t.integer :metal_cost
      t.integer :stone_cost
      t.integer :wood_cost

      t.timestamps
    end
  end
end
