# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_03_071647) do

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

  create_table "cards", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "card_token", null: false
    t.string "customer_token", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_cards_on_company_id"
  end

  create_table "careers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "job_category_id"
    t.integer "year"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_careers_on_creator_id"
  end

  create_table "companies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.integer "prefecture_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
  end

  create_table "company_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "company_id"
    t.bigint "follow_id"
    t.index ["company_id", "follow_id"], name: "index_company_relationships_on_company_id_and_follow_id", unique: true
    t.index ["company_id"], name: "index_company_relationships_on_company_id"
    t.index ["follow_id"], name: "index_company_relationships_on_follow_id"
  end

  create_table "contracts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id"
    t.bigint "creator_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_contracts_on_company_id"
    t.index ["creator_id"], name: "index_contracts_on_creator_id"
    t.index ["order_id"], name: "index_contracts_on_order_id"
  end

  create_table "creator_relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.bigint "follow_id"
    t.index ["creator_id", "follow_id"], name: "index_creator_relationships_on_creator_id_and_follow_id", unique: true
    t.index ["creator_id"], name: "index_creator_relationships_on_creator_id"
    t.index ["follow_id"], name: "index_creator_relationships_on_follow_id"
  end

  create_table "creators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "kana_first_name", null: false
    t.string "kana_last_name", null: false
    t.datetime "birth_date", null: false
    t.integer "prefecture_id", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_creators_on_email", unique: true
    t.index ["reset_password_token"], name: "index_creators_on_reset_password_token", unique: true
  end

  create_table "introductions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "pr_text"
    t.integer "price_per_hour"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_introductions_on_creator_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_id"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_likes_on_creator_id"
    t.index ["order_id"], name: "index_likes_on_order_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "content"
    t.bigint "room_id"
    t.string "category", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title", null: false
    t.text "content", null: false
    t.integer "award", null: false
    t.datetime "last_day", null: false
    t.datetime "deadline", null: false
    t.bigint "company_id"
    t.integer "job_category_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
  end

  create_table "outlines", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "outline"
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_outlines_on_company_id"
  end

  create_table "payments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "price", null: false
    t.bigint "order_id", null: false
    t.index ["order_id"], name: "index_payments_on_order_id"
  end

  create_table "portforios", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "outline"
    t.string "url"
    t.text "detail"
    t.string "github"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_portforios_on_creator_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.bigint "order_id"
    t.bigint "creator_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_rooms_on_company_id"
    t.index ["creator_id"], name: "index_rooms_on_creator_id"
    t.index ["order_id"], name: "index_rooms_on_order_id"
  end

  create_table "skills", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "skill_name"
    t.integer "level_id"
    t.integer "year"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_skills_on_creator_id"
  end

  create_table "sns_credentials", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "provider"
    t.string "uid"
    t.bigint "creator_id"
    t.index ["creator_id"], name: "index_sns_credentials_on_creator_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cards", "companies"
  add_foreign_key "careers", "creators"
  add_foreign_key "company_relationships", "companies"
  add_foreign_key "company_relationships", "creators", column: "follow_id"
  add_foreign_key "contracts", "companies"
  add_foreign_key "contracts", "creators"
  add_foreign_key "contracts", "orders"
  add_foreign_key "creator_relationships", "companies", column: "follow_id"
  add_foreign_key "creator_relationships", "creators"
  add_foreign_key "introductions", "creators"
  add_foreign_key "likes", "creators"
  add_foreign_key "likes", "orders"
  add_foreign_key "messages", "rooms"
  add_foreign_key "orders", "companies"
  add_foreign_key "outlines", "companies"
  add_foreign_key "payments", "orders"
  add_foreign_key "portforios", "creators"
  add_foreign_key "rooms", "companies"
  add_foreign_key "rooms", "creators"
  add_foreign_key "rooms", "orders"
  add_foreign_key "skills", "creators"
  add_foreign_key "sns_credentials", "creators"
end
