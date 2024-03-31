# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :episodes, id: false, primary_key: :key do |t|
      t.primary_key :key, null: false
      t.string :title, null: false, limit: 200
      t.text :short_summary, null: false
      t.text :long_summary, null: false
      t.text :subtitle, null: false
      t.integer :season
      t.integer :number

      t.timestamps
    end
    add_index :episodes, :key, unique: true
    add_index :episodes, :season
    add_index :episodes, :number
  end
end
