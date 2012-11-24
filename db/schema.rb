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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121124141518) do

  create_table "flats", :force => true do |t|
    t.string   "nickname"
    t.string   "postcode"
    t.text     "description"
    t.float    "geocode_lat"
    t.float    "geocode_long"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "flat_id"
    t.text     "contents"
    t.boolean  "received"
    t.string   "context"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shop_items", :force => true do |t|
    t.integer  "flat_id"
    t.integer  "user_want_id"
    t.integer  "user_bought_id"
    t.decimal  "price"
    t.string   "name"
    t.boolean  "paid_back"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "flat_id"
    t.float    "geocode_lat"
    t.float    "geocode_long"
    t.string   "phone_number"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
