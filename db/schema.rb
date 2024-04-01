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

ActiveRecord::Schema[7.1].define(version: 2024_03_31_210116) do
  create_table "episode_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_episode_types_on_name", unique: true
  end

  create_table "episodes", primary_key: "number", id: :string, force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "short_summary", null: false
    t.text "long_summary", null: false
    t.text "subtitle", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "type_id", null: false
    t.index ["number"], name: "index_episodes_on_number", unique: true
    t.index ["type_id"], name: "index_episodes_on_type_id"
  end

  create_table "feeds_spotify_for_podcasters", primary_key: "episode_number", id: :string, force: :cascade do |t|
    t.string "source_url", null: false
    t.string "title", null: false
    t.string "url", null: false
    t.string "audio_file_url", null: false
    t.string "image_url", null: false
    t.datetime "published_at", null: false
    t.text "description", null: false
    t.string "duration", null: false
    t.boolean "explicit", null: false
    t.string "season_number"
    t.string "story_number"
    t.string "episode_type", null: false
    t.string "guid", null: false
    t.string "creator", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_number"], name: "index_feeds_spotify_for_podcasters_on_episode_number", unique: true
    t.index ["published_at"], name: "index_feeds_spotify_for_podcasters_on_published_at"
  end

  add_foreign_key "episodes", "episode_types", column: "type_id"
  add_foreign_key "feeds_spotify_for_podcasters", "episodes", column: "episode_number", primary_key: "number"
end