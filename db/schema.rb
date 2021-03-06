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

ActiveRecord::Schema.define(version: 20161028001321) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "parking_pass_id", null: false
    t.integer "user_id",         null: false
    t.string  "start_time",      null: false
    t.string  "end_time",        null: false
    t.string  "first_name",      null: false
    t.string  "last_name",       null: false
    t.string  "phone_number",    null: false
    t.date    "date",            null: false
    t.integer "status"
    t.index ["parking_pass_id"], name: "index_bookings_on_parking_pass_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "parking_passes", force: :cascade do |t|
    t.integer  "user_id",        null: false
    t.integer  "booking_id"
    t.string   "address",        null: false
    t.integer  "price_per_hour", null: false
    t.integer  "pass_number",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lat",            null: false
    t.string   "lng",            null: false
    t.index ["booking_id"], name: "index_parking_passes_on_booking_id", using: :btree
    t.index ["user_id"], name: "index_parking_passes_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                             null: false
    t.string   "last_name",                              null: false
    t.integer  "parking_pass_id"
    t.boolean  "admin",                  default: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.integer  "booking_id"
    t.string   "phone_number"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
