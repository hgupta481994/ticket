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

ActiveRecord::Schema.define(version: 20180316053446) do

  create_table "attachements", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "avatar"
    t.integer "task_id"
    t.index ["task_id"], name: "index_attachements_on_task_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "notice"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "checked", default: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "requirements", force: :cascade do |t|
    t.date "end"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.string "avatar"
    t.integer "user_id"
    t.integer "teamlead_id"
    t.index ["teamlead_id"], name: "index_requirements_on_teamlead_id"
    t.index ["user_id"], name: "index_requirements_on_user_id"
  end

  create_table "requirements_users", id: false, force: :cascade do |t|
    t.integer "requirement_id", null: false
    t.integer "user_id", null: false
    t.index ["requirement_id"], name: "index_requirements_users_on_requirement_id"
    t.index ["user_id"], name: "index_requirements_users_on_user_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "start"
    t.date "end"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "teamlead_id"
    t.integer "tasktype_id"
    t.integer "requirement_id"
    t.integer "status_id"
    t.index ["requirement_id"], name: "index_tasks_on_requirement_id"
    t.index ["status_id"], name: "index_tasks_on_status_id"
    t.index ["tasktype_id"], name: "index_tasks_on_tasktype_id"
    t.index ["teamlead_id"], name: "index_tasks_on_teamlead_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "tasktypes", force: :cascade do |t|
    t.string "ttype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teamleads", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "isadmin", default: false
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
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "teamlead_id", default: 1
    t.integer "usertype_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["teamlead_id"], name: "index_users_on_teamlead_id"
    t.index ["username"], name: "index_users_on_username", unique: true
    t.index ["usertype_id"], name: "index_users_on_usertype_id"
  end

  create_table "usertypes", force: :cascade do |t|
    t.string "utype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
