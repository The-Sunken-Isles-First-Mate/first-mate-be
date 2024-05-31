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

ActiveRecord::Schema[7.1].define(version: 2024_05_31_203908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

end
