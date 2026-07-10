# This file is auto-generated from the current state of the database.
ActiveRecord::Schema[7.1].define(version: 2026_07_10_000001) do
  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.boolean "done", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
