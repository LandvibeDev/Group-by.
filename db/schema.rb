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

ActiveRecord::Schema.define(version: 20170821105536) do


  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end


  create_table "comments", force: :cascade do |t|
    t.integer "content_id"
    t.string "user_name"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content_id"], name: "index_comments_on_content_id"
  end

  create_table "contents", force: :cascade do |t|
    t.integer "group_id"
    t.string "title"
    t.text "content"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.index ["group_id"], name: "index_contents_on_group_id"
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.text "content"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "group_categories", force: :cascade do |t|
    t.integer "group_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_group_categories_on_category_id"
    t.index ["group_id"], name: "index_group_categories_on_group_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "groupProfile"
    t.string "groupCover"
  end

  create_table "groups_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.index ["group_id"], name: "index_groups_users_on_group_id"
    t.index ["user_id"], name: "index_groups_users_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "invite_user"
    t.string "invite_project"
    t.string "invite_user_email"
    t.string "invite_project_title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string "content"
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_messages_on_project_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.boolean "complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "projects_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.boolean "admin_user"
    t.index ["project_id"], name: "index_projects_users_on_project_id"
    t.index ["user_id"], name: "index_projects_users_on_user_id"
  end

  create_table "pushes", force: :cascade do |t|
    t.integer "user_id"
    t.string "message"
    t.integer "pusher_id"
    t.boolean "isGroup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pushes_on_user_id"
  end

  create_table "team_events", force: :cascade do |t|
    t.integer "project_id"
    t.string "title"
    t.text "content"
    t.string "image"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_team_events_on_project_id"
  end


  create_table "team_events_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "team_event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_event_id"], name: "index_team_events_users_on_team_event_id"
    t.index ["user_id"], name: "index_team_events_users_on_user_id"
  end

  create_table "user_categories", force: :cascade do |t|
    t.integer "user_id"
    t.integer "category_id"
    t.index ["category_id"], name: "index_user_categories_on_category_id"
    t.index ["user_id"], name: "index_user_categories_on_user_id"

  end

  create_table "usermails", force: :cascade do |t|
    t.integer "userpop3_id"
    t.integer "user_id"
    t.string "subject"
    t.text "content"
    t.string "date"
    t.string "from"
    t.string "to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_usermails_on_user_id"
    t.index ["userpop3_id"], name: "index_usermails_on_userpop3_id"
  end

  create_table "userpop3s", force: :cascade do |t|
    t.integer "user_id"
    t.string "title"
    t.string "email"
    t.string "password"
    t.integer "port"
    t.string "pop3"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_userpop3s_on_user_id"
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
    t.string "name"
    t.string "organization"
    t.string "category"
    t.string "userProfile"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
