# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090923181156) do

  create_table "computers", :force => true do |t|
    t.integer  "user_id"
    t.text     "description"
    t.string   "host",        :null => false
    t.string   "mac",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "port"
  end

  create_table "messages", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "email"
    t.integer  "user_id"
    t.string   "user_agent"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "permalink"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "navigation", :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",           :default => false
    t.string   "activation_code"
    t.string   "password_reset"
    t.string   "firstname"
    t.string   "lastname"
  end

end
