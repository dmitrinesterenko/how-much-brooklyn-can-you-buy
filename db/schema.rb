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

ActiveRecord::Schema.define(version: 20140330180915) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "listings", force: true do |t|
    t.integer  "realty_id",    limit: 8
    t.string   "thumb"
    t.string   "url"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "address"
    t.string   "locality"
    t.float    "price"
    t.string   "zip"
    t.string   "listing_type"
    t.string   "neighborhood"
    t.string   "beds"
    t.string   "baths"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sqft"
    t.text     "description"
    t.uuid     "public_id",              default: "uuid_generate_v4()"
  end

  create_table "localities", force: true do |t|
    t.string   "name"
    t.uuid     "locality_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.uuid     "locality_id"
  end

  add_index "neighborhoods", ["name"], name: "neighborhood_name_index", order: {"name"=>:desc}, using: :btree

  create_table "searches", force: true do |t|
    t.string   "area"
    t.float    "spend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
