# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

def load_items_from_csv(file_path)
  CSV.foreach(file_path, headers: true) do |row|
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

# Load items from the CSV file
csv_file_path = Rails.root.join('db/items.csv')
load_items_from_csv(csv_file_path)