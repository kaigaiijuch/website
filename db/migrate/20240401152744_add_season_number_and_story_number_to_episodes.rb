# frozen_string_literal: true

class AddSeasonNumberAndStoryNumberToEpisodes < ActiveRecord::Migration[7.1]
  def change
    change_table :episodes do |t|
      t.integer :season_number
      t.integer :story_number
      t.index %i[season_number story_number], unique: true
    end
  end
end
