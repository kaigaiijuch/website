# frozen_string_literal: true

class AddDisplayOrderToEpisodePhoto < ActiveRecord::Migration[7.1]
  def up # rubocop:disable Metrics/MethodLength
    add_column :episode_photos, :display_order, :integer, null: true

    # Assign distinct display_order per episode so the unique index can be added
    execute(<<-SQL.squish)
      UPDATE episode_photos
      SET display_order = (
        SELECT ordinal FROM (
          SELECT id, ROW_NUMBER() OVER (PARTITION BY episode_number ORDER BY id) AS ordinal
          FROM episode_photos
        ) sub WHERE sub.id = episode_photos.id
      )
    SQL

    change_column_null :episode_photos, :display_order, false
    change_column_default :episode_photos, :display_order, 1
    add_check_constraint :episode_photos, 'display_order > 0', name: 'check_display_order_positive'
    add_index :episode_photos, %i[episode_number display_order], unique: true
  end

  def down
    remove_index :episode_photos, %i[episode_number display_order], unique: true
    remove_check_constraint :episode_photos, name: 'check_display_order_positive'
    remove_column :episode_photos, :display_order
  end
end
