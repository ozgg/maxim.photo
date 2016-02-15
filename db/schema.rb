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

ActiveRecord::Schema.define(version: 20160215202100) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "theme_id"
    t.string   "name",       null: false
    t.string   "slug",       null: false
    t.string   "image"
  end

  add_index "albums", ["theme_id"], name: "index_albums_on_theme_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string "code", null: false
    t.string "slug", null: false
  end

  create_table "photos", force: :cascade do |t|
    t.boolean  "visible",     default: true, null: false
    t.string   "name",                       null: false
    t.string   "image",                      null: false
    t.string   "description"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "preview"
    t.integer  "album_id"
  end

  add_index "photos", ["album_id"], name: "index_photos_on_album_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title",      null: false
    t.string   "image"
    t.string   "lead"
    t.text     "body",       null: false
  end

  create_table "themes", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "visible",              default: true, null: false
    t.integer  "priority",   limit: 2, default: 0,    null: false
    t.string   "name",                                null: false
    t.string   "slug",                                null: false
    t.string   "image"
  end

  add_index "themes", ["slug"], name: "index_themes_on_slug", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "login",           null: false
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "albums", "themes"
  add_foreign_key "photos", "albums"
end
