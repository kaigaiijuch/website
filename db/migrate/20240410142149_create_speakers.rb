# frozen_string_literal: true

class CreateSpeakers < ActiveRecord::Migration[7.1]
  def change
    create_table :speakers do |t|
      t.string :name, null: false
      t.string :image_path, null: false
      t.string :global_id, null: false

      t.timestamps
    end
  end
end
