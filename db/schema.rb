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

ActiveRecord::Schema[7.0].define(version: 2019_02_04_151800) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonus_accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.float "bonuses", default: 0.0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_bonus_accounts_on_user_id"
  end

  create_table "bonus_logs", force: :cascade do |t|
    t.bigint "bonus_account_id", null: false, comment: "Who will receive bonus for inviting new user with this UserOrder?"
    t.bigint "user_order_id", null: false
    t.float "bonuses", default: 0.0, null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["bonus_account_id"], name: "index_bonus_logs_on_bonus_account_id"
    t.index ["user_order_id"], name: "index_bonus_logs_on_user_order_id"
  end

  create_table "user_orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "product", null: false
    t.float "price", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["user_id"], name: "index_user_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

end
