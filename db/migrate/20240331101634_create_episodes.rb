# frozen_string_literal: true

class CreateEpisodes < ActiveRecord::Migration[7.1]
  def change
    create_table :episodes, id: false, primary_key: :number do |t|
      t.primary_key :number, :string, null: false
      t.string :title, null: false, limit: 200
      t.text :short_summary, null: false
      t.text :long_summary, null: false
      t.text :subtitle, null: false

      t.timestamps
      t.index :number, unique: true
    end
  end
end
