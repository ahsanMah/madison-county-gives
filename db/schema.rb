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

ActiveRecord::Schema.define(version: 20171204033008) do

  create_table "campaign_changes", force: :cascade do |t|
    t.integer "campaign_id"
    t.string "name"
    t.text "description"
    t.date "start_date"
    t.integer "goal"
    t.string "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "organization_id"
  end

  create_table "campaigns", force: :cascade do |t|
    t.integer "organization_id"
    t.text "description"
    t.date "start_date"
    t.integer "goal"
    t.boolean "is_active"
    t.boolean "is_featured"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "name"
  end

  create_table "organizations", force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.string "primary_contact"
    t.string "address"
    t.string "email"
    t.text "description"
    t.boolean "is_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "campaign_id"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.decimal "amount", precision: 10, scale: 2
    t.string "transaction_id"
    t.datetime "time"
    t.boolean "is_anonymous"
    t.boolean "is_konosioni"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_questions", force: :cascade do |t|
    t.text "question"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "short_responses", force: :cascade do |t|
    t.integer "short_question_id"
    t.integer "organization_id"
    t.text "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "status_updates", force: :cascade do |t|
    t.text "text"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "campaign_id"
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
