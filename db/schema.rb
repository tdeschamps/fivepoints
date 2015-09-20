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

ActiveRecord::Schema.define(version: 20150920163319) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "authentifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authorizations", force: :cascade do |t|
    t.text     "provider"
    t.text     "uid"
    t.integer  "user_id"
    t.text     "token"
    t.text     "secret"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "name"
    t.text     "link"
    t.datetime "token_expiry"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture"
  end

  add_index "authorizations", ["uid"], name: "index_authorizations_on_uid", using: :btree
  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id", using: :btree

  create_table "black_book_places", force: :cascade do |t|
    t.integer  "black_book_id"
    t.integer  "place_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "story"
  end

  add_index "black_book_places", ["black_book_id"], name: "index_black_book_places_on_black_book_id", using: :btree
  add_index "black_book_places", ["place_id"], name: "index_black_book_places_on_place_id", using: :btree

  create_table "black_books", force: :cascade do |t|
    t.string   "city",              limit: 255
    t.integer  "user_id"
    t.text     "story"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",              limit: 255
    t.string   "state",             limit: 255
    t.string   "country",           limit: 255
    t.text     "formatted_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "slug"
  end

  add_index "black_books", ["slug"], name: "index_black_books_on_slug", using: :btree
  add_index "black_books", ["user_id"], name: "index_black_books_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.text     "name"
    t.text     "plural_name"
    t.text     "short_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "categories_places", id: false, force: :cascade do |t|
    t.integer "place_id"
    t.integer "category_id"
  end

  add_index "categories_places", ["category_id", "place_id"], name: "index_categories_places_on_category_id_and_place_id", using: :btree

  create_table "followships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
  end

  add_index "followships", ["followed_id"], name: "index_followships_on_followed_id", using: :btree
  add_index "followships", ["follower_id", "followed_id"], name: "index_followships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "followships", ["follower_id"], name: "index_followships_on_follower_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

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
    t.text     "foursquare_id"
    t.text     "category"
    t.text     "state"
    t.text     "foursquare_picture_url"
    t.float    "foursquare_rating"
    t.text     "twitter"
    t.text     "facebook"
    t.text     "facebook_username"
    t.text     "facebook_name"
    t.text     "phone"
    t.text     "formatted_phone"
    t.text     "description"
    t.string   "slug"
    t.integer  "price"
    t.string   "price_description"
  end

  add_index "places", ["slug"], name: "index_places_on_slug", using: :btree

  create_table "social_friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
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

  add_index "uploaded_files", ["imageable_id", "imageable_type"], name: "index_uploaded_files_on_imageable_id_and_imageable_type", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
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
    t.text     "biography"
    t.boolean  "admin",                              default: false, null: false
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
