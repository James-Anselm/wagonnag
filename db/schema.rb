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

ActiveRecord::Schema.define(version: 20160116190715) do

  create_table "cars", force: :cascade do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "nickname"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "odometer"
  end

  add_index "cars", ["user_id"], name: "index_cars_on_user_id"

  create_table "maintenance_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_id"
    t.string   "description"
    t.integer  "interval"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "maintenance_items", ["car_id"], name: "index_maintenance_items_on_car_id"

  create_table "maintenence_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_id"
    t.string   "description"
    t.integer  "interval"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "maintenence_items", ["car_id"], name: "index_maintenence_items_on_car_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
