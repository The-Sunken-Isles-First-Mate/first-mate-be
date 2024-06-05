# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# add a conditional to confirm that we're not in production and if not, run this.  If production, no deletions
require 'csv'
CampaignItem.delete_all
Item.delete_all

def load_items_from_csv(csv)
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

# Load items from the CSV file
csv_text = File.read(Rails.root.join('db', 'items.csv'))
csv = CSV.parse(csv_text, headers: true)
load_items_from_csv(csv)

campaign = Campaign.create!(name: 'Test Campaign')
user1 = User.create!(username: 'testuser1', uid: 'adfdf233', token: 'ajdkflk32jflkjfdsfkl23jrlk2fjadf')
user2 = User.create!(username: 'testuser2', uid: 'abc123def', token: 'aldj2om2l23j2305')
user3 = User.create!(username: 'testuser3', uid: 'asdf3333', token: 'kljkl4tlkj43lt2lk23')
user2_character = user2.characters.create!(name: 'Test Character 1', dnd_class: 'Barbarian', dnd_race: 'Dragonborn')
user3_character = user3.characters.create!(name: 'Test Character 2', dnd_class: 'Bard', dnd_race: 'Human')
UserCampaign.create!(user_id: user1.id, campaign_id: campaign.id, role: 1)
UserCampaign.create!(user_id: user2.id, campaign_id: campaign.id, role: 0, character_id: user2_character.id)
UserCampaign.create!(user_id: user3.id, campaign_id: campaign.id, role: 0, character_id: user3_character.id)







puts "Seeded successfully"
