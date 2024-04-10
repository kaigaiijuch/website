# frozen_string_literal: true

class CreateHosts < ActiveRecord::Migration[7.1]
  def change
    create_table :hosts do |t|
      t.string :nickname, null: false, index: { unique: true }
      t.string :name, null: false
      t.string :english_name, null: false

      t.timestamps
    end
  end
end
