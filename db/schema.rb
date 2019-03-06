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

ActiveRecord::Schema.define(version: 20190305190201) do

  create_table "drinks", force: :cascade do |t|
    t.string  "name"
    t.boolean "alcohol?"
    t.string  "liquor"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "drink_id"
    t.float   "rating"
    t.string  "comment"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.integer "age"
  end

  create_table "wishes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "drink_id"
    t.string  "drink_name"
  end

end
