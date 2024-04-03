# frozen_string_literal: true

class CreateFeedsSpotifyForPodcasters < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    create_table :feeds_spotify_for_podcasters, id: false, primary_key: :episode_number do |t|
      t.primary_key :episode_number, :string, null: false, index: { unique: true }
      t.string :source_url, null: false
      t.string :title, null: false
      t.string :url, null: false
      t.string :audio_file_url, null: false
      t.string :image_url, null: false
      t.datetime :published_at, null: false, index: true
      t.text :description, null: false
      t.string :duration, null: false
      t.boolean :explicit, null: false # rubocop:disable Rails/ThreeStateBooleanColumn
      t.string :season_number
      t.string :story_number
      t.string :episode_type, null: false
      t.string :guid, null: false
      t.string :creator, null: false

      t.timestamps
      t.foreign_key :episodes, column: :episode_number, primary_key: :number
    end
  end
end
