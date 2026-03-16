# frozen_string_literal: true

class AddWidthToEpisodePhotos < ActiveRecord::Migration[7.1]
  def change
    add_column :episode_photos, :width_percent, :integer, null: false, default: 100
  end
end
