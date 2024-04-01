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

ActiveRecord::Schema[7.1].define(version: 2024_04_01_154222) do
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
    t.integer "season_number"
    t.integer "story_number"
    t.index ["number"], name: "index_episodes_on_number", unique: true
    t.index ["season_number", "story_number"], name: "index_episodes_on_season_number_and_story_number", unique: true
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

  create_table "guest_infos", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.string "tagline", null: false
    t.string "job_title", null: false
    t.text "introduction", null: false
    t.string "abroad_living_summary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_guest_infos_on_guest_id"
  end

  create_table "guest_interviews", id: false, force: :cascade do |t|
    t.string "episode_number", null: false
    t.integer "guest_info_id", null: false
    t.index ["episode_number", "guest_info_id"], name: "index_guest_interviews_on_episode_number_and_guest_info_id", unique: true
    t.index ["guest_info_id"], name: "index_guest_interviews_on_guest_info_id"
  end

  create_table "guests", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "name", null: false
    t.string "english_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_guests_on_nickname", unique: true
  end

  add_foreign_key "episodes", "episode_types", column: "type_id"
  add_foreign_key "feeds_spotify_for_podcasters", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "guest_infos", "guests"
  add_foreign_key "guest_interviews", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "guest_interviews", "guest_infos"

  create_view "published_episodes", sql_definition: <<-SQL
      SELECT
   *
  FROM episodes
  JOIN feeds_spotify_for_podcasters ON feeds_spotify_for_podcasters.episode_number = episodes.number
  SQL
end
