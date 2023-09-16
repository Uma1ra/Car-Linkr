# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_16_111104) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "buy_request_id"
    t.integer "sell_request_id"
    t.string "name"
    t.string "phone_number"
    t.string "post_code"
    t.integer "category", null: false
    t.boolean "is_done", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["buy_request_id"], name: "index_appointments_on_buy_request_id"
    t.index ["customer_id"], name: "index_appointments_on_customer_id"
    t.index ["sell_request_id"], name: "index_appointments_on_sell_request_id"
  end

  create_table "buy_requests", force: :cascade do |t|
    t.integer "car_id", null: false
    t.text "comment"
    t.datetime "option_a", null: false
    t.datetime "option_b", null: false
    t.datetime "option_c", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_buy_requests_on_car_id"
  end

  create_table "car_genres", force: :cascade do |t|
    t.integer "car_id", null: false
    t.integer "subgenre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_car_genres_on_car_id"
    t.index ["subgenre_id"], name: "index_car_genres_on_subgenre_id"
  end

  create_table "cars", force: :cascade do |t|
    t.string "name", null: false
    t.text "detail"
    t.integer "price", null: false
    t.string "color"
    t.integer "passenger_amount"
    t.date "year", null: false
    t.string "chassis_code", null: false
    t.integer "mileage", null: false
    t.boolean "is_km", default: true, null: false
    t.integer "shaken_period", null: false
    t.date "shaken_finish"
    t.string "grade"
    t.integer "engine_capacity"
    t.integer "transmission", null: false
    t.integer "fuel", null: false
    t.boolean "is_available", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "last_name"
    t.string "first_name"
    t.string "last_name_kana"
    t.string "first_name_kana"
    t.string "phone_number"
    t.string "post_code"
    t.boolean "is_deleted", default: false
    t.boolean "is_guest", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sell_details", force: :cascade do |t|
    t.string "car_name", null: false
    t.string "chassis_no", null: false
    t.date "year", null: false
    t.string "chassis_code", null: false
    t.integer "mileage", null: false
    t.boolean "is_km", default: true, null: false
    t.integer "shaken_period", null: false
    t.date "shaken_finish"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "sell_requests", force: :cascade do |t|
    t.integer "sell_detail_id", null: false
    t.text "comment"
    t.datetime "option_a", null: false
    t.datetime "option_b", null: false
    t.datetime "option_c", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["sell_detail_id"], name: "index_sell_requests_on_sell_detail_id"
  end

  create_table "subgenres", force: :cascade do |t|
    t.integer "genre_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_subgenres_on_genre_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "buy_requests"
  add_foreign_key "appointments", "customers"
  add_foreign_key "appointments", "sell_requests"
  add_foreign_key "buy_requests", "cars"
  add_foreign_key "car_genres", "cars"
  add_foreign_key "car_genres", "subgenres"
  add_foreign_key "sell_requests", "sell_details"
  add_foreign_key "subgenres", "genres"
end
