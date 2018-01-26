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

ActiveRecord::Schema.define(version: 20180124080618) do

  create_table "boxes", force: :cascade do |t|
    t.integer "move_id"
    t.string  "name"
    t.string  "location"
  end

  create_table "items", force: :cascade do |t|
    t.integer "box_id"
    t.string  "name"
  end

  create_table "moves", force: :cascade do |t|
    t.integer "owner_id"
    t.string  "origin"
    t.string  "destination"
    t.date    "move_date"
  end

  create_table "owners", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
