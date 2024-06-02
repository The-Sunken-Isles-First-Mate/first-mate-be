require 'csv'

class CreateItemsFromCsv < ActiveRecord::Migration[7.1]
  def up 
    csv_text = File.read(Rails.root.join('db', 'items.csv'))
    csv = CSV.parse(csv_text, headers: true)

    csv.each do |row|
      Item.create!(
        name: row['name'],
        animal_products_cost: row['animal_products_cost'] || 0,
        cloth_cost: row['cloth_cost'] || 0,
        farmed_goods_cost: row['farmed_goods_cost'] || 0,
        food_cost: row['food_cost'] || 0,
        foraged_goods_cost: row['foraged_goods_cost'] || 0,
        metal_cost: row['metal_cost'] || 0,
        stone_cost: row['stone_cost'] || 0,
        wood_cost: row['wood_cost'] || 0,
        monster_parts_cost: row['monster_parts_cost'] || 0
      )
    end
  end

  def down
    Item.delete_all
  end
end
