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

ActiveRecord::Schema.define(version: 20150613145618) do

  create_table "contents", force: true do |t|
    t.integer  "subject_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.binary   "data"
  end

  add_index "contents", ["subject_id"], name: "index_contents_on_subject_id", using: :btree
  add_index "contents", ["user_id"], name: "index_contents_on_user_id", using: :btree

  create_table "courses", force: true do |t|
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "courses", ["subject_id"], name: "index_courses_on_subject_id", using: :btree

  create_table "courses_questions", id: false, force: true do |t|
    t.integer  "question_id"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "courses_questions", ["course_id"], name: "index_courses_questions_on_course_id", using: :btree
  add_index "courses_questions", ["question_id"], name: "index_courses_questions_on_question_id", using: :btree

  create_table "questions", force: true do |t|
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "text"
    t.text     "answer"
    t.boolean  "hot"
    t.datetime "date"
    t.integer  "type"
  end

  add_index "questions", ["subject_id"], name: "index_questions_on_subject_id", using: :btree

  create_table "questions_subjects", id: false, force: true do |t|
    t.integer "question_id"
    t.integer "subject_id"
  end

  add_index "questions_subjects", ["question_id"], name: "index_questions_subjects_on_question_id", using: :btree
  add_index "questions_subjects", ["subject_id"], name: "index_questions_subjects_on_subject_id", using: :btree

  create_table "questions_tests", id: false, force: true do |t|
    t.integer  "test_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions_tests", ["question_id"], name: "index_questions_tests_on_question_id", using: :btree
  add_index "questions_tests", ["test_id"], name: "index_questions_tests_on_test_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "level"
    t.text     "comment"
  end

  add_index "ratings", ["question_id"], name: "index_ratings_on_question_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "responses", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.text     "text"
    t.decimal  "correction",  precision: 4, scale: 2
  end

  add_index "responses", ["question_id"], name: "index_responses_on_question_id", using: :btree
  add_index "responses", ["user_id"], name: "index_responses_on_user_id", using: :btree

  create_table "roles", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "subjects", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "tests", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "tests", ["course_id"], name: "index_tests_on_course_id", using: :btree
  add_index "tests", ["user_id"], name: "index_tests_on_user_id", using: :btree

  create_table "user_course_roles", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_course_roles", ["course_id"], name: "index_user_course_roles_on_course_id", using: :btree
  add_index "user_course_roles", ["user_id"], name: "index_user_course_roles_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_index "users", ["role_id"], name: "index_users_on_role_id", using: :btree

end
