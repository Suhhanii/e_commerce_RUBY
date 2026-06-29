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

ActiveRecord::Schema[8.1].define(version: 2026_06_29_071118) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "patient_id", null: false
    t.bigint "physician_id", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["physician_id"], name: "index_appointments_on_physician_id"
  end

  create_table "assemblies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "assemblies_parts", id: false, force: :cascade do |t|
    t.bigint "assembly_id"
    t.datetime "created_at", null: false
    t.bigint "part_id"
    t.datetime "updated_at", null: false
    t.index ["assembly_id"], name: "index_assemblies_parts_on_assembly_id"
    t.index ["part_id"], name: "index_assemblies_parts_on_part_id"
  end

  create_table "authors", force: :cascade do |t|
    t.integer "author_books", default: 0
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "book_orders", force: :cascade do |t|
    t.bigint "book_id", null: false
    t.integer "count"
    t.datetime "created_at", null: false
    t.integer "quantity"
    t.string "statuss", default: "pending", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_book_orders_on_book_id"
  end

  create_table "book_ordr", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "string"
    t.text "text"
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.integer "lock_version"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "chips", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date_of_expiry"
    t.date "date_of_packing"
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.bigint "subdevice_id"
    t.datetime "updated_at", null: false
    t.index ["subdevice_id"], name: "index_devices_on_subdevice_id"
  end

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "entries", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "entryable_id"
    t.string "entryable_type"
    t.datetime "updated_at", null: false
  end

  create_table "examples", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ex"
    t.integer "ex_id"
    t.datetime "updated_at", null: false
  end

  create_table "laptops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string "body"
    t.datetime "created_at", null: false
    t.string "subject"
    t.datetime "updated_at", null: false
  end

  create_table "nics", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "laptop_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["laptop_id"], name: "index_nics_on_laptop_id"
  end

  create_table "parts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "part_number"
    t.datetime "updated_at", null: false
  end

  create_table "patients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer "contact"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "physicians", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "image_id"
    t.string "image_type"
    t.datetime "updated_at", null: false
    t.index ["image_type", "image_id"], name: "index_pictures_on_image"
  end

  create_table "portraits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "papertype"
    t.string "poster"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "inventory_count"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "sub_devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "device_id"
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["device_id"], name: "index_sub_devices_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  create_table "wifi_connections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "nic_id", null: false
    t.datetime "updated_at", null: false
    t.index ["nic_id"], name: "index_wifi_connections_on_nic_id", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "patients"
  add_foreign_key "appointments", "physicians"
  add_foreign_key "book_orders", "books"
  add_foreign_key "books", "authors"
  add_foreign_key "devices", "devices", column: "subdevice_id"
  add_foreign_key "nics", "laptops"
  add_foreign_key "sessions", "users"
  add_foreign_key "sub_devices", "sub_devices", column: "device_id"
  add_foreign_key "wifi_connections", "nics"
end
