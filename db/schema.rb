# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_27_044555) do

  create_table "items", force: :cascade do |t|
    t.string "name", null: false
    t.text "info", null: false
    t.integer "category_id", null: false
    t.integer "sales_status_id", null: false
    t.integer "shipping_fee_status_id", null: false
    t.integer "prefecture_id", null: false
    t.integer "scheduled_delivery_id", null: false
    t.integer "price", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  add_foreign_key "items", "users"
end
