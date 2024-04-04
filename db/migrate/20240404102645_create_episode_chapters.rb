# frozen_string_literal: true

class CreateEpisodeChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_chapters do |t|
      t.string :episode_number, null: false, index: true
      t.foreign_key :episodes, column: :episode_number, primary_key: :number
      t.string :title, null: false
      t.string :time, null: false

      t.timestamps
    end
  end
end
