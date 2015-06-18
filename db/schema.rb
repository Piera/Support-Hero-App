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

ActiveRecord::Schema.define(version: 20150618215509) do

  create_table "calendars", force: :cascade do |t|
    t.datetime "date"
    t.integer  "heroes_id"
  end

  create_table "heroes", force: :cascade do |t|
    t.string "name"
  end

  create_table "starting_orders", force: :cascade do |t|
    t.integer "hero_id"
    t.integer "order"
    t.integer "heroes_id"
  end

  add_index "starting_orders", ["hero_id"], name: "index_starting_orders_on_hero_id"

end
