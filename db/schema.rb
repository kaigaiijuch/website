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

ActiveRecord::Schema[7.1].define(version: 2024_04_04_102645) do
  create_table "episode_chapters", force: :cascade do |t|
    t.string "episode_number", null: false
    t.string "title", null: false
    t.string "time", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_number"], name: "index_episode_chapters_on_episode_number"
  end

  create_table "episode_references", force: :cascade do |t|
    t.string "episode_number", null: false
    t.string "link", null: false
    t.text "caption", null: false
    t.integer "display_order", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_number", "display_order"], name: "index_episode_references_on_episode_number_and_display_order", unique: true
    t.check_constraint "display_order > 0"
  end

  create_table "episode_types", primary_key: "name", id: :string, force: :cascade do |t|
    t.index ["name"], name: "index_episode_types_on_name", unique: true
  end

  create_table "episodes", primary_key: "number", id: :string, force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "summary", null: false
    t.text "long_summary", null: false
    t.text "subtitle", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "season_number"
    t.integer "story_number"
    t.string "type_name", null: false
    t.index ["number"], name: "index_episodes_on_number", unique: true
    t.index ["season_number", "story_number"], name: "index_episodes_on_season_number_and_story_number", unique: true
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

  create_table "guest_interview_profiles", force: :cascade do |t|
    t.integer "guest_id", null: false
    t.string "tagline", null: false
    t.string "job_title", null: false
    t.text "introduction", null: false
    t.string "abroad_living_summary", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "guest_name", null: false
    t.string "image_path", null: false
    t.index ["guest_id"], name: "index_guest_interview_profiles_on_guest_id"
  end

  create_table "guest_interviews", id: false, force: :cascade do |t|
    t.string "episode_number", null: false
    t.integer "guest_interview_profile_id", null: false
    t.integer "display_order", default: 1, null: false
    t.index ["episode_number", "display_order"], name: "index_guest_interviews_on_episode_number_and_display_order", unique: true
    t.index ["episode_number", "guest_interview_profile_id"], name: "idx_on_episode_number_guest_interview_profile_id_967e3dfe76", unique: true
    t.index ["guest_interview_profile_id"], name: "index_guest_interviews_on_guest_interview_profile_id"
    t.check_constraint "display_order > 0", name: "check_display_order_positive"
  end

  create_table "guests", force: :cascade do |t|
    t.string "nickname", null: false
    t.string "name", null: false
    t.string "english_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nickname"], name: "index_guests_on_nickname", unique: true
  end

  add_foreign_key "episode_chapters", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "episode_references", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "episodes", "episode_types", column: "type_name", primary_key: "name"
  add_foreign_key "feeds_spotify_for_podcasters", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "guest_interview_profiles", "guests"
  add_foreign_key "guest_interviews", "episodes", column: "episode_number", primary_key: "number"
  add_foreign_key "guest_interviews", "guest_interview_profiles"

  create_view "published_episodes", sql_definition: <<-SQL
      SELECT
       *
      FROM episodes
      JOIN feeds_spotify_for_podcasters ON feeds_spotify_for_podcasters.episode_number = episodes.number
  SQL
end
