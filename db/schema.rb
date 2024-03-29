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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120516090221) do

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "share_info_id"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.integer  "from"
    t.integer  "to"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recieves_and_tos", :force => true do |t|
    t.integer  "share_info_id"
    t.integer  "user_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "replies", :force => true do |t|
    t.integer  "comment_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "share_images", :force => true do |t|
    t.integer  "share_info_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.text     "description"
    t.string   "website_url"
  end

  create_table "share_infos", :force => true do |t|
    t.integer  "from"
    t.string   "share_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "share_links", :force => true do |t|
    t.integer  "share_info_id"
    t.string   "website_url"
    t.text     "description"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "title"
  end

  create_table "share_texts", :force => true do |t|
    t.integer  "share_info_id"
    t.text     "content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "website_url"
  end

  create_table "share_videos", :force => true do |t|
    t.integer  "share_info_id"
    t.text     "description"
    t.string   "video_url"
    t.string   "website_url"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "system_messages", :force => true do |t|
    t.integer  "from"
    t.integer  "to"
    t.string   "message_type"
    t.boolean  "is_read",      :default => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "temps", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "email"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.boolean  "is_admin",         :default => false
    t.string   "avatar_file_name"
  end

end
