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

ActiveRecord::Schema.define(version: 2019_06_29_071000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "word_card_result_summaries", force: :cascade do |t|
    t.integer "word_card_id", null: false
    t.integer "result_count", null: false
    t.integer "remember_count", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_card_id"], name: "index_word_card_result_summaries_on_word_card_id", unique: true
  end

  create_table "word_card_results", force: :cascade do |t|
    t.integer "word_card_id", null: false
    t.boolean "remember", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["word_card_id", "created_at"], name: "index_word_card_results_on_word_card_id_and_created_at"
  end

  create_table "word_cards", force: :cascade do |t|
    t.integer "user_id", null: false
    t.text "word", null: false
    t.text "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["user_id"], name: "index_word_cards_on_user_id"
  end

end
