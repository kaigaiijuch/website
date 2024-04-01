# frozen_string_literal: true

class CreateGuests < ActiveRecord::Migration[7.1]
  def change
    create_table :guests do |t|
      t.string :nickname, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :english_name, null: false

      t.timestamps
    end
  end
end
