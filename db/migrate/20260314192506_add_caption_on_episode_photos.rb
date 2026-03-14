# frozen_string_literal: true

class AddCaptionOnEpisodePhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :episode_photos, :caption, :text
  end
end
