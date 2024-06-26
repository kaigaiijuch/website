# frozen_string_literal: true

class AddImagePathToEpisodes < ActiveRecord::Migration[7.1]
  def change
    add_column :episodes, :image_path, :string, null: false, default: 'logos/logo_kaigaiiju-channel.webp'
    change_column_default :episodes, :image_path, from: 'logos/logo_kaigaiiju-channel.webp', to: nil
  end
end
