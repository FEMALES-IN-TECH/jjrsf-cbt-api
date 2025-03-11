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

ActiveRecord::Schema[7.1].define(version: 2025_03_11_123252) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "clacbt_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clacbt_question_id", null: false
    t.string "option", limit: 1, null: false
    t.text "answer_text", null: false
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clacbt_question_id"], name: "index_clacbt_answers_on_clacbt_question_id"
  end

  create_table "clacbt_candidates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clacbt_exam_id", null: false
    t.string "email", null: false
    t.integer "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clacbt_exam_id", "email"], name: "index_clacbt_candidates_on_clacbt_exam_id_and_email", unique: true
    t.index ["clacbt_exam_id"], name: "index_clacbt_candidates_on_clacbt_exam_id"
  end

  create_table "clacbt_exams", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clacbt_user_id", null: false
    t.string "name", null: false
    t.integer "duration", null: false
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "exam_code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clacbt_user_id"], name: "index_clacbt_exams_on_clacbt_user_id"
    t.index ["exam_code"], name: "index_clacbt_exams_on_exam_code", unique: true
  end

  create_table "clacbt_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "clacbt_exam_id", null: false
    t.text "question", null: false
    t.integer "mark", default: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["clacbt_exam_id"], name: "index_clacbt_questions_on_clacbt_exam_id"
  end

  create_table "clacbt_users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clacbt_users_on_email", unique: true
  end

  add_foreign_key "clacbt_answers", "clacbt_questions"
  add_foreign_key "clacbt_candidates", "clacbt_exams"
  add_foreign_key "clacbt_exams", "clacbt_users"
  add_foreign_key "clacbt_questions", "clacbt_exams"
end
