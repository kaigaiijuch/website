# frozen_string_literal: true

class DropIdFromEpisodeTypes < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :episodes, :episode_types
    remove_column :episodes, :type_id
    remove_column :episode_types, :id
    add_column :episodes, :type_name, :string, null: false, default: 'full'
    change_column :episode_types, :name, :string, primary_key: true
    add_foreign_key :episodes, :episode_types, column: :type_name, primary_key: :name
    change_column_default :episodes, :type_name, nil
  end

  def down
    remove_foreign_key :episodes, :episode_types, column: :type_name
    remove_column :episodes, :type_name, :string
    add_column :episodes, :type_id, :integer
    change_column :episode_types, :name, :string, primary_key: false
    add_column :episode_types, :id, :primary_key, null: false # rubocop:disable Rails/DangerousColumnNames, Rails/NotNullColumn
    add_foreign_key :episodes, :episode_types, column: :type_id, primary_key: :id
  end
end
