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

ActiveRecord::Schema.define(version: 20150927032613) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "board_members", force: :cascade do |t|
    t.integer "user_id"
    t.integer "board_id"
    t.boolean "admin",    default: false
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_assignments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "list_id"
    t.string   "organization_name"
    t.text     "organization_summary"
    t.string   "position_applied_for"
    t.text     "position_description"
    t.string   "advocate"
    t.string   "tech_stack"
    t.text     "recent_articles"
    t.integer  "glassdoor_rating"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "title"
    t.text     "description"
    t.integer  "points",               default: 1
    t.integer  "priority",             default: 1
    t.string   "next_task",            default: "Find Advocate"
    t.boolean  "archived",             default: false
  end

  create_table "lists", force: :cascade do |t|
    t.integer  "board_id"
    t.string   "name"
    t.integer  "position_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "movements", force: :cascade do |t|
    t.string   "current_list"
    t.integer  "card_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "description"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "title"
    t.boolean  "completed",  default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "notes"
  end

  create_table "users", force: :cascade do |t|
    t.string   "auth_token"
    t.string   "name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "email"
    t.string   "password_hash"
    t.string   "location"
    t.string   "password_digest"
  end

end
