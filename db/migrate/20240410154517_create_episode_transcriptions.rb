# frozen_string_literal: true

class CreateEpisodeTranscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_transcriptions do |t|
      t.belongs_to :episode_speaker, null: false, foreign_key: true
      t.text :text, null: false
      t.time :start_at, null: false
      t.time :end_at, null: false

      t.timestamps
    end
  end
end
