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

ActiveRecord::Schema.define(version: 20151031121535) do

  create_table "category_difficulties", force: true do |t|
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "category_difficulties", ["category_id", "category_type"], name: "index_category_difficulties_on_category_id_and_category_type"
  add_index "category_difficulties", ["user_id"], name: "index_category_difficulties_on_user_id"

  create_table "contents", force: true do |t|
    t.integer  "category_id"
    t.string   "category_type"
    t.integer  "owner_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.text     "description"
    t.integer  "access_count"
    t.boolean  "download_protected"
    t.boolean  "shareable"
  end

  add_index "contents", ["category_id", "category_type"], name: "index_contents_on_category_id_and_category_type"
  add_index "contents", ["owner_id"], name: "index_contents_on_owner_id"

  create_table "course_news", force: true do |t|
    t.integer  "owner_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.text     "text"
    t.datetime "date"
  end

  add_index "course_news", ["course_id"], name: "index_course_news_on_course_id"
  add_index "course_news", ["owner_id"], name: "index_course_news_on_owner_id"

  create_table "course_registration_requests", force: true do |t|
    t.integer  "requirer_id"
    t.integer  "course_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "text"
    t.datetime "response_date"
    t.text     "response"
    t.boolean  "accepted"
  end

  add_index "course_registration_requests", ["course_id"], name: "index_course_registration_requests_on_course_id"
  add_index "course_registration_requests", ["requirer_id"], name: "index_course_registration_requests_on_requirer_id"

  create_table "courses", force: true do |t|
    t.integer  "category_id"
    t.string   "category_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "name"
    t.text     "description"
  end

  add_index "courses", ["category_id", "category_type"], name: "index_courses_on_category_id_and_category_type"

  create_table "data_imports", force: true do |t|
    t.integer  "role_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "model"
    t.integer  "status",            default: -1
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  add_index "data_imports", ["role_id"], name: "index_data_imports_on_role_id"

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

  create_table "lesson_contents", force: true do |t|
    t.integer  "lesson_id"
    t.integer  "content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lesson_contents", ["content_id"], name: "index_lesson_contents_on_content_id"
  add_index "lesson_contents", ["lesson_id"], name: "index_lesson_contents_on_lesson_id"

  create_table "lesson_questions", force: true do |t|
    t.integer  "question_id"
    t.integer  "lesson_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lesson_questions", ["lesson_id"], name: "index_lesson_questions_on_lesson_id"
  add_index "lesson_questions", ["question_id"], name: "index_lesson_questions_on_question_id"

  create_table "lessons", force: true do |t|
    t.integer  "course_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
  end

  add_index "lessons", ["course_id"], name: "index_lessons_on_course_id"

  create_table "media", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "reference"
    t.boolean  "is_attachment"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  add_index "media", ["owner_id", "owner_type"], name: "index_media_on_owner_id_and_owner_type"

  create_table "permissions", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "question_categories", force: true do |t|
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
    t.integer  "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "text"
    t.text     "answer"
    t.boolean  "hot"
    t.string   "source"
    t.datetime "date"
    t.string   "style"
    t.string   "tags"
  end

  add_index "questions", ["owner_id"], name: "index_questions_on_owner_id"

  create_table "ratings", id: false, force: true do |t|
    t.integer  "owner_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "value"
  end

  add_index "ratings", ["owner_id"], name: "index_ratings_on_owner_id"
  add_index "ratings", ["question_id"], name: "index_ratings_on_question_id"

  create_table "recommendations", force: true do |t|
    t.integer  "user_source_id"
    t.integer  "user_destination_id"
    t.integer  "course_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "recommendations", ["course_id"], name: "index_recommendations_on_course_id"
  add_index "recommendations", ["resource_id", "resource_type"], name: "index_recommendations_on_resource_id_and_resource_type"
  add_index "recommendations", ["user_destination_id"], name: "index_recommendations_on_user_destination_id"
  add_index "recommendations", ["user_source_id"], name: "index_recommendations_on_user_source_id"

  create_table "registration_requests", force: true do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.datetime "birthdate"
    t.text     "text"
    t.datetime "response_date"
    t.text     "response"
    t.boolean  "accepted"
  end

  create_table "response_choices", force: true do |t|
    t.integer  "response_id"
    t.integer  "question_choice_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "response_choices", ["response_id"], name: "index_response_choices_on_response_id"

  create_table "responses", force: true do |t|
    t.integer  "question_id"
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "text"
  end

  add_index "responses", ["owner_id"], name: "index_responses_on_owner_id"
  add_index "responses", ["question_id"], name: "index_responses_on_question_id"

  create_table "role_permissions", force: true do |t|
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

  create_table "settings", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "preferred_language"
  end

  add_index "settings", ["user_id"], name: "index_settings_on_user_id"

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
    t.integer  "owner_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "name"
    t.text     "description"
  end

  add_index "tests", ["course_id"], name: "index_tests_on_course_id"
  add_index "tests", ["owner_id"], name: "index_tests_on_owner_id"

  create_table "user_courses", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_courses", ["course_id"], name: "index_user_courses_on_course_id"
  add_index "user_courses", ["user_id"], name: "index_user_courses_on_user_id"

  create_table "users", force: true do |t|
    t.integer  "role_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birthdate"
    t.text     "about"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
