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

ActiveRecord::Schema[7.0].define(version: 2023_07_25_202130) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agents", comment: "User agents", force: :cascade do |t|
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.index ["name"], name: "index_agents_on_name", unique: true
  end

  create_table "components", comment: "Biovision CMS components", force: :cascade do |t|
    t.integer "priority", limit: 2, default: 1, null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "settings", default: {}, null: false
    t.index ["slug"], name: "index_components_on_slug", unique: true
  end

  create_table "ip_addresses", comment: "IP addresses", force: :cascade do |t|
    t.inet "ip", null: false
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ip"], name: "index_ip_addresses_on_ip", unique: true
  end

  create_table "login_attempts", comment: "Failed login attempts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "agent_id"
    t.bigint "ip_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password", default: "", null: false
    t.index ["agent_id"], name: "index_login_attempts_on_agent_id"
    t.index ["ip_address_id"], name: "index_login_attempts_on_ip_address_id"
    t.index ["user_id"], name: "index_login_attempts_on_user_id"
  end

  create_table "tokens", comment: "Authentication tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "agent_id"
    t.bigint "ip_address_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_used"
    t.boolean "active", default: true, null: false
    t.string "token", null: false
    t.index ["agent_id"], name: "index_tokens_on_agent_id"
    t.index ["ip_address_id"], name: "index_tokens_on_ip_address_id"
    t.index ["last_used"], name: "index_tokens_on_last_used"
    t.index ["token"], name: "index_tokens_on_token", unique: true
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", comment: "Users", force: :cascade do |t|
    t.string "slug", null: false
    t.string "password_digest", null: false
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "login_attempts", "agents", on_update: :cascade, on_delete: :nullify
  add_foreign_key "login_attempts", "ip_addresses", on_update: :cascade, on_delete: :nullify
  add_foreign_key "login_attempts", "users", on_update: :cascade, on_delete: :cascade
  add_foreign_key "tokens", "agents", on_update: :cascade, on_delete: :nullify
  add_foreign_key "tokens", "ip_addresses", on_update: :cascade, on_delete: :nullify
  add_foreign_key "tokens", "users", on_update: :cascade, on_delete: :cascade
end
