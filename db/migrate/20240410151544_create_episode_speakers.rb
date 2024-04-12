# frozen_string_literal: true

class CreateEpisodeSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_speakers do |t|
      t.string :episode_number, null: false
      t.foreign_key :episodes, column: :episode_number, primary_key: :number

      t.belongs_to :speaker, null: false, foreign_key: true

      t.string :role_name, null: false
      t.foreign_key :episode_speaker_roles, column: :role_name, primary_key: :name

      t.timestamps
      t.index %i[episode_number speaker_id], unique: true
      t.index %i[role_name episode_number], unique: true
    end
  end
end
