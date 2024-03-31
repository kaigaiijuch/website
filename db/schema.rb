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

ActiveRecord::Schema[7.1].define(version: 2024_03_31_101634) do
  create_table "episodes", primary_key: "key", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "short_summary", null: false
    t.text "long_summary", null: false
    t.text "subtitle", null: false
    t.integer "season"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_episodes_on_key", unique: true
    t.index ["number"], name: "index_episodes_on_number"
    t.index ["season"], name: "index_episodes_on_season"
  end

end
