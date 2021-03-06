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

ActiveRecord::Schema.define(version: 20160701020103) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nicknames", force: :cascade do |t|
    t.string   "name"
    t.integer  "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "nicknames", ["person_id"], name: "index_nicknames_on_person_id", using: :btree

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.text     "urls"
    t.text     "chat_usernames"
    t.text     "photo"
    t.text     "additional_info"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "timezone_id"
    t.string   "personal_website"
    t.string   "email"
    t.string   "domain"
    t.string   "location"
    t.string   "pronoun_nominative"
    t.string   "pronoun_oblique"
    t.string   "pronoun_possessive"
    t.string   "birthday_year"
    t.string   "birthday_month"
    t.string   "birthday_day"
  end

  create_table "timezones", force: :cascade do |t|
    t.string   "offset"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "nicknames", "people"
end
