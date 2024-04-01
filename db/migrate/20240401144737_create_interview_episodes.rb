# frozen_string_literal: true

class CreateInterviewEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :interview_episodes, id: false, primary_key: :episode_number do |t|
      t.primary_key :episode_number, :string, null: false
      t.integer :season_number, null: false
      t.integer :story_number, null: false

      t.timestamps
      t.index %i[season_number story_number], unique: true
      t.foreign_key :episodes, column: :episode_number, primary_key: :number
    end
  end
end
