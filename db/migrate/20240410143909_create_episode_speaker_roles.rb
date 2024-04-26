# frozen_string_literal: true

class CreateEpisodeSpeakerRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_speaker_roles, id: false do |t|
      t.string :name, index: { unique: true }, null: false
    end
  end
end
