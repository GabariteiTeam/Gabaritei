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

ActiveRecord::Schema.define(version: 20150720123715) do

  create_table "contents", force: true do |t|
    t.integer  "category_id"
    t.string   "category_type"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.text     "description"
    t.integer  "access_count"
    t.boolean  "download_protected"
    t.boolean  "shareable"
  end

  add_index "contents", ["category_id", "category_type"], name: "index_contents_on_category_id_and_category_type"
  add_index "contents", ["user_id"], name: "index_contents_on_user_id"

  create_table "course_contents", id: false, force: true do |t|
    t.integer  "course_id"
    t.integer  "contents_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "course_contents", ["contents_id"], name: "index_course_contents_on_contents_id"
  add_index "course_contents", ["course_id"], name: "index_course_contents_on_course_id"

  create_table "course_news", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.text     "text"
    t.datetime "date"
  end

  add_index "course_news", ["course_id"], name: "index_course_news_on_course_id"
  add_index "course_news", ["user_id"], name: "index_course_news_on_user_id"

  create_table "course_questions", id: false, force: true do |t|
    t.integer  "question_id"
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "course_questions", ["course_id"], name: "index_course_questions_on_course_id"
  add_index "course_questions", ["question_id"], name: "index_course_questions_on_question_id"

  create_table "course_registration_requests", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "text"
    t.datetime "response_date"
    t.text     "response"
    t.boolean  "accepted"
  end

  add_index "course_registration_requests", ["course_id"], name: "index_course_registration_requests_on_course_id"
  add_index "course_registration_requests", ["user_id"], name: "index_course_registration_requests_on_user_id"

  create_table "courses", force: true do |t|
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.text     "description"
  end

  add_index "courses", ["category_id", "category_type"], name: "index_courses_on_category_id_and_category_type"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "fields", force: true do |t|
    t.integer  "subject_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  add_index "fields", ["subject_id"], name: "index_fields_on_subject_id"

  create_table "medias", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "reference"
    t.string   "media_type"
  end

  add_index "medias", ["owner_id", "owner_type"], name: "index_medias_on_owner_id_and_owner_type"

  create_table "permissions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "question_categories", id: false, force: true do |t|
    t.integer  "question_id"
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "question_categories", ["category_id", "category_type"], name: "index_question_categories_on_category_id_and_category_type"
  add_index "question_categories", ["question_id"], name: "index_question_categories_on_question_id"

  create_table "question_choices", force: true do |t|
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "text"
    t.boolean  "correct"
  end

  add_index "question_choices", ["question_id"], name: "index_question_choices_on_question_id"

  create_table "questions", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "text"
    t.text     "answer"
    t.boolean  "hot"
    t.datetime "date"
    t.string   "style"
  end

  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "ratings", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "value"
  end

  add_index "ratings", ["question_id"], name: "index_ratings_on_question_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "recommendations", force: true do |t|
    t.integer  "user_source_id"
    t.integer  "user_destination_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "recommendations", ["resource_id", "resource_type"], name: "index_recommendations_on_resource_id_and_resource_type"
  add_index "recommendations", ["user_destination_id"], name: "index_recommendations_on_user_destination_id"
  add_index "recommendations", ["user_source_id"], name: "index_recommendations_on_user_source_id"

  create_table "registration_requests", force: true do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "birthdate"
    t.text     "text"
    t.datetime "response_date"
    t.text     "response"
    t.boolean  "accepted"
  end

  create_table "response_choices", force: true do |t|
    t.integer  "response_id"
    t.integer  "question_choices_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "response_choices", ["response_id"], name: "index_response_choices_on_response_id"

  create_table "responses", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "text"
  end

  add_index "responses", ["question_id"], name: "index_responses_on_question_id"
  add_index "responses", ["user_id"], name: "index_responses_on_user_id"

  create_table "role_permissions", id: false, force: true do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "role_permissions", ["permission_id"], name: "index_role_permissions_on_permission_id"
  add_index "role_permissions", ["role_id"], name: "index_role_permissions_on_role_id"

  create_table "roles", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  create_table "subjects", force: true do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  create_table "test_questions", id: false, force: true do |t|
    t.integer  "test_id"
    t.integer  "question_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "max_score",   precision: 4, scale: 2
  end

  add_index "test_questions", ["question_id"], name: "index_test_questions_on_question_id"
  add_index "test_questions", ["test_id"], name: "index_test_questions_on_test_id"

  create_table "test_responses", id: false, force: true do |t|
    t.integer  "test_id"
    t.integer  "response_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.decimal  "score",       precision: 4, scale: 2
    t.text     "comment"
  end

  add_index "test_responses", ["response_id"], name: "index_test_responses_on_response_id"
  add_index "test_responses", ["test_id"], name: "index_test_responses_on_test_id"

  create_table "tests", force: true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  add_index "tests", ["course_id"], name: "index_tests_on_course_id"
  add_index "tests", ["user_id"], name: "index_tests_on_user_id"

  create_table "user_course_roles", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_course_roles", ["course_id"], name: "index_user_course_roles_on_course_id"
  add_index "user_course_roles", ["user_id"], name: "index_user_course_roles_on_user_id"

  create_table "user_deficit_categories", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "user_deficit_categories", ["category_id", "category_type"], name: "index_user_deficit_categories_on_category_id_and_category_type"
  add_index "user_deficit_categories", ["user_id"], name: "index_user_deficit_categories_on_user_id"

  create_table "user_roles", id: false, force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id"
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id"

  create_table "users", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password"
    t.datetime "birthdate"
    t.text     "about"
  end

end
