# frozen_string_literal: true

class DropTimestampsFromEpisodes < ActiveRecord::Migration[7.1]
  def change
    remove_column :episodes, :created_at, :datetime, null: false
    remove_column :episodes, :updated_at, :datetime, null: false
  end
end
