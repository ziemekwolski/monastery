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

ActiveRecord::Schema.define(version: 20150428032105) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "upload_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug",                       null: false
    t.boolean  "is_listed",   default: true, null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "category_translations", ["category_id"], name: "index_category_translations_on_category_id", using: :btree
  add_index "category_translations", ["locale"], name: "index_category_translations_on_locale", using: :btree

  create_table "idioma_phrases", force: :cascade do |t|
    t.string   "locale"
    t.string   "i18n_key"
    t.text     "i18n_value"
    t.datetime "translated_at"
    t.datetime "flagged_at"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "post_translations", force: :cascade do |t|
    t.integer  "post_id",         null: false
    t.string   "locale",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.string   "subtitle"
    t.text     "summary"
    t.text     "body"
    t.text     "seo_description"
    t.string   "seo_tags"
  end

  add_index "post_translations", ["locale"], name: "index_post_translations_on_locale", using: :btree
  add_index "post_translations", ["post_id"], name: "index_post_translations_on_post_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "slug",                            null: false
    t.string   "title"
    t.string   "subtitle"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "category_id"
    t.integer  "upload_id"
    t.boolean  "is_static",       default: false, null: false
    t.string   "source_url"
    t.string   "source_name"
    t.string   "seo_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
    t.text     "snippet"
    t.text     "summary"
    t.boolean  "is_listed",       default: true,  null: false
    t.string   "seo_tags"
  end

  create_table "redirects", force: :cascade do |t|
    t.string   "from_slug",         limit: 255, null: false
    t.string   "to_path",           limit: 255
    t.integer  "redirectable_id"
    t.string   "redirectable_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "setting_translations", force: :cascade do |t|
    t.integer  "setting_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "value"
  end

  add_index "setting_translations", ["locale"], name: "index_setting_translations_on_locale", using: :btree
  add_index "setting_translations", ["setting_id"], name: "index_setting_translations_on_setting_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_type",   default: "string"
    t.string   "name"
    t.text     "description"
  end

  create_table "uploads", force: :cascade do |t|
    t.string   "name"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_translations", force: :cascade do |t|
    t.integer  "user_id",                null: false
    t.string   "locale",     limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "snippet"
  end

  add_index "user_translations", ["locale"], name: "index_user_translations_on_locale", using: :btree
  add_index "user_translations", ["user_id"], name: "index_user_translations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.string   "linkedin"
    t.string   "twitter"
    t.string   "crypted_password",                null: false
    t.string   "salt",                            null: false
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer  "upload_id"
    t.string   "github"
    t.text     "snippet"
  end

  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", using: :btree

end
