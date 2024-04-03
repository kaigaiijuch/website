# frozen_string_literal: true

class AddLabelToEpisodes < ActiveRecord::Migration[7.1]
  def up
    add_column :episodes, :label, :string
    add_index :episodes, :label, unique: true
    execute 'UPDATE episodes SET label = number'
    change_column_null :episodes, :label, false
  end

  def down
    remove_index :episodes, :label, unique: true
    remove_column :episodes, :label, :string
  end
end
