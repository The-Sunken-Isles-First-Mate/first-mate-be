# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_01_095702) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "campaign_items", force: :cascade do |t|
    t.bigint "item_id", null: false
    t.bigint "campaign_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity_owned"
    t.index ["campaign_id"], name: "index_campaign_items_on_campaign_id"
    t.index ["item_id"], name: "index_campaign_items_on_item_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.string "name"
    t.integer "week", default: 0
    t.integer "animal_products", default: 0
    t.integer "cloth", default: 0
    t.integer "farmed_goods", default: 0
    t.integer "food", default: 0
    t.integer "foraged_goods", default: 0
    t.integer "metal", default: 0
    t.integer "monster_parts", default: 0
    t.integer "stone", default: 0
    t.integer "wood", default: 0
    t.integer "villagers", default: 120
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "animal_products_cost"
    t.integer "cloth_cost"
    t.integer "farmed_goods_cost"
    t.integer "food_cost"
    t.integer "foraged_goods_cost"
    t.integer "metal_cost"
    t.integer "stone_cost"
    t.integer "wood_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "campaign_items", "campaigns"
  add_foreign_key "campaign_items", "items"
  create_table "management_forms", force: :cascade do |t|
    t.bigint "campaign_id", null: false
    t.integer "week", default: 0
    t.integer "animal_products", default: 0
    t.integer "cloth", default: 0
    t.integer "farmed_goods", default: 0
    t.integer "food", default: 0
    t.integer "foraged_goods", default: 0
    t.integer "metal", default: 0
    t.integer "monster_parts", default: 0
    t.integer "stone", default: 0
    t.integer "wood", default: 0
    t.integer "light_armor", default: 0
    t.integer "medium_armor", default: 0
    t.integer "heavy_armor", default: 0
    t.integer "simple_weapon", default: 0
    t.integer "martial_weapon", default: 0
    t.integer "ammunition", default: 0
    t.integer "adventuring_supplies", default: 0
    t.integer "assassins_blood", default: 0
    t.integer "malice", default: 0
    t.integer "midnight_tears", default: 0
    t.integer "serpent_venom", default: 0
    t.integer "truth_serum", default: 0
    t.integer "oil_of_slipperiness", default: 0
    t.integer "potion_of_climbing", default: 0
    t.integer "potion_of_healing", default: 0
    t.integer "potion_of_water_breathing", default: 0
    t.integer "barge", default: 0
    t.integer "coracle", default: 0
    t.integer "double_hulled_sailing_canoe", default: 0
    t.integer "keelboat", default: 0
    t.integer "raft", default: 0
    t.integer "single_hulled_sailing_canoe", default: 0
    t.integer "ballista", default: 0
    t.integer "cabin", default: 0
    t.integer "magical_defenses", default: 0
    t.integer "storage", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["campaign_id"], name: "index_management_forms_on_campaign_id"
  end

  add_foreign_key "management_forms", "campaigns"
end
