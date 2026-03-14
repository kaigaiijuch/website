# frozen_string_literal: true

class RemoveUniqueIndexEpisodeNumberOnEpisodePhotos < ActiveRecord::Migration[7.1]
  def change
    remove_index :episode_photos, :episode_number, unique: true
    add_index :episode_photos, :episode_number
  end
end
