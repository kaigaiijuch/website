# frozen_string_literal: true

class CreateEpisodeSpeakerTranscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_speaker_transcriptions do |t|
      t.belongs_to :episode_speaker, null: false, foreign_key: true
      t.text :text, null: false
      t.string :start_at, null: false
      t.string :end_at, null: false

      t.timestamps
    end
  end
end
