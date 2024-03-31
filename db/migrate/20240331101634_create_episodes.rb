# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes, id: :string do |t|
      t.string :key
      t.integer :season
      t.integer :number
      t.string :title, limit: 200
      t.text :long_summary
      t.text :short_summary
      t.text :subtitle

      t.timestamps
    end
    add_index :episodes, :key, unique: true
    add_index :episodes, :season
    add_index :episodes, :number
  end
end
