# frozen_string_literal: true

class CreateEpisodeReferences < ActiveRecord::Migration[7.1]
  def change
    create_table :episode_references do |t|
      t.string :episode_number, null: false, index: false
      t.foreign_key :episodes, column: :episode_number, primary_key: :number
      t.string :link, null: false
      t.text :caption, null: false
      t.integer :display_order, null: false, default: 1
      t.check_constraint 'display_order > 0'

      t.timestamps

      t.index %i[episode_number display_order], unique: true
    end
  end
end
