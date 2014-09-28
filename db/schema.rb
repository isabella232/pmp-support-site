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

ActiveRecord::Schema.define(version: 20140927201914) do

  create_table "password_resets", force: true do |t|
    t.string   "token"
    t.string   "email_address"
    t.string   "user_name"
    t.string   "user_guid"
    t.string   "host"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recent_stories", force: true do |t|
    t.string   "story_guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "title"
    t.string   "permalink"
    t.string   "image_url"
    t.string   "creator_name"
    t.string   "show_name"
    t.date     "published_date"
  end

  create_table "user_stats", force: true do |t|
    t.string   "user_guid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "story_count", default: 0
    t.integer  "image_count", default: 0
    t.integer  "audio_count", default: 0
    t.integer  "video_count", default: 0
  end

end
