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

ActiveRecord::Schema.define(version: 20150614010524) do

  create_table "users", force: :cascade do |t|
    t.string   "name",                        limit: 255
    t.string   "username",                    limit: 255
    t.text     "description",                 limit: 65535
    t.string   "url",                         limit: 255
    t.string   "twitter_uid",                 limit: 255
    t.string   "twitter_access_token",        limit: 255
    t.string   "twitter_access_token_secret", limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "users", ["twitter_uid"], name: "index_users_on_twitter_uid", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", using: :btree

end
