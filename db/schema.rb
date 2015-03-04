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

ActiveRecord::Schema.define(version: 20150304110637) do

  create_table "events", force: :cascade do |t|
    t.datetime "time_created"
    t.string   "repo_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "fetch_id"
    t.text     "hsh"
  end

  create_table "fetches", force: :cascade do |t|
    t.string   "get_info"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "starting_at"
    t.datetime "ending_at"
  end

end
