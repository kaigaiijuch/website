# frozen_string_literal: true

class CreateEpisodePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_photos do |t| # rubocop:disable Rails/CreateTableWithTimestamps
      t.string :episode_number, null: false
      t.string :image_path, null: false

      t.foreign_key :episodes, column: :episode_number, primary_key: :number
      t.index :episode_number, unique: true
    end
  end
end
