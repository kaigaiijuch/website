# frozen_string_literal: true

class DropTimestampsFromEpisodeTypes < ActiveRecord::Migration[7.1]
  def up
    remove_timestamps :episode_types
  end

  def down
    add_timestamps :episode_types, default: -> { 'CURRENT_TIMESTAMP' }
    change_column_default :episode_types, :created_at, nil
    change_column_default :episode_types, :updated_at, nil
  end
end
