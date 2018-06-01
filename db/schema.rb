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

ActiveRecord::Schema.define(version: 2018_05_15_124728) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "brands", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.string "name"
    t.string "handle"
    t.string "address"
    t.string "phone"
    t.string "email"
    t.string "web"
    t.text "description"
    t.float "latitude"
    t.float "longitude"
    t.datetime "deleted_at"
    t.integer "stories_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviews_count", default: 0
    t.float "avg_rating", default: 0.0
    t.integer "inspirations_count", default: 0
    t.index ["category_id"], name: "index_brands_on_category_id"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
    t.index ["handle"], name: "index_brands_on_handle", unique: true
  end

  create_table "categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "for", null: false
    t.integer "items_count", default: 0
    t.integer "integer", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "inspirations", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "inspiring_id"
    t.string "inspiring_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inspiring_id", "inspiring_type"], name: "index_inspirations_on_inspiring_id_and_inspiring_type"
    t.index ["user_id"], name: "index_inspirations_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "parent_id"
    t.text "body"
    t.datetime "read_at"
    t.integer "recipient_id"
    t.integer "messageable_id"
    t.string "messageable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["messageable_id", "messageable_type"], name: "index_messages_on_messageable_id_and_messageable_type"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "reviews", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "reviewable_id"
    t.string "reviewable_type"
    t.integer "rating"
    t.integer "user_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reviewable_id", "reviewable_type"], name: "index_reviews_on_reviewable_id_and_reviewable_type"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "created_by_id"
    t.integer "user_id"
    t.integer "brand_id"
    t.integer "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["brand_id", "user_id"], name: "index_roles_on_brand_id_and_user_id"
  end

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.bigint "target_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "social_links", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "social_linkable_type"
    t.string "social_linkable_id"
    t.string "name"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["social_linkable_type", "social_linkable_id"], name: "social_linkable"
  end

  create_table "stories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "brand_id"
    t.integer "category_id"
    t.string "title"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "inspirations_count", default: 0
    t.index ["category_id"], name: "index_stories_on_category_id"
    t.index ["deleted_at"], name: "index_stories_on_deleted_at"
  end

  create_table "taggings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type"], name: "index_taggings_on_tag_id_and_taggable_id_and_taggable_type"
  end

  create_table "tags", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_tags_on_category"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.string "handle"
    t.string "phone"
    t.text "about"
    t.integer "user_type"
    t.string "provider_name"
    t.string "provider_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stories_count", default: 0
    t.integer "inspirations_count", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["handle"], name: "index_users_on_handle", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
