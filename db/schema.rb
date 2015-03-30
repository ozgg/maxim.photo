# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150330162059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.integer  "photos_count",   default: 0,     null: false
    t.boolean  "hidden",         default: false, null: false
    t.integer  "priority",       default: 0,     null: false
    t.string   "image"
    t.string   "slug",                           null: false
    t.string   "name_ru",                        null: false
    t.string   "name_en",                        null: false
    t.string   "name_es",                        null: false
    t.text     "description_ru"
    t.text     "description_en"
    t.text     "description_es"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "categories", force: :cascade do |t|
    t.integer  "visibility",                 null: false
    t.integer  "photo_count",    default: 0, null: false
    t.integer  "priority",       default: 0, null: false
    t.string   "image"
    t.string   "slug",                       null: false
    t.string   "name_ru",                    null: false
    t.string   "name_en",                    null: false
    t.string   "name_es",                    null: false
    t.text     "description_ru"
    t.text     "description_en"
    t.text     "description_es"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "photo_categories", force: :cascade do |t|
    t.integer  "photo_id",    null: false
    t.integer  "category_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "photo_categories", ["category_id"], name: "index_photo_categories_on_category_id", using: :btree
  add_index "photo_categories", ["photo_id"], name: "index_photo_categories_on_photo_id", using: :btree

  create_table "photos", force: :cascade do |t|
    t.integer  "album_id"
    t.string   "image",          null: false
    t.string   "name_ru"
    t.string   "name_en"
    t.string   "name_es"
    t.text     "description_ru"
    t.text     "description_en"
    t.text     "description_es"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "photo_categories", "categories"
  add_foreign_key "photo_categories", "photos"
  add_foreign_key "photos", "albums"
end
