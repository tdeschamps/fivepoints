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

ActiveRecord::Schema.define(version: 20150218103140) do

  create_table "authentifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorizations", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "token"
    t.string   "secret"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "link"
    t.datetime "token_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["uid"], name: "index_authorizations_on_uid"
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id"

  create_table "city_guide_places", force: :cascade do |t|
    t.integer  "city_guide_id"
    t.integer  "place_id"
    t.integer  "row_order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "city_guide_places", ["city_guide_id"], name: "index_city_guide_places_on_city_guide_id"
  add_index "city_guide_places", ["place_id"], name: "index_city_guide_places_on_place_id"

  create_table "city_guides", force: :cascade do |t|
    t.string   "city",              limit: 255
    t.integer  "user_id"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 255
    t.string   "state",             limit: 255
    t.string   "country",           limit: 255
    t.string   "formatted_address"
  end

  add_index "city_guides", ["user_id"], name: "index_city_guides_on_user_id"

  create_table "followships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
  end

  add_index "followships", ["followed_id"], name: "index_followships_on_followed_id"
  add_index "followships", ["follower_id", "followed_id"], name: "index_followships_on_follower_id_and_followed_id", unique: true
  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id"

  create_table "places", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "city",                   limit: 255
    t.integer  "zipcode"
    t.string   "address",                limit: 255
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "ranking"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "foursquare_id"
    t.string   "category"
    t.string   "state"
    t.string   "foursquare_picture_url"
    t.float    "foursquare_rating"
  end

  create_table "uploaded_files", force: :cascade do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name",    limit: 255
    t.string   "file_content_type", limit: 255
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "uploaded_files", ["imageable_id", "imageable_type"], name: "index_uploaded_files_on_imageable_id_and_imageable_type"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "picture",                limit: 255
    t.string   "name",                   limit: 255
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "token",                  limit: 255
    t.datetime "token_expiry"
    t.string   "username",               limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
