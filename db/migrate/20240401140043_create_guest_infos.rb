# frozen_string_literal: true

class CreateGuestInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_infos do |t|
      t.references :guest, null: false, foreign_key: true
      t.string :tagline, null: false
      t.string :job_title, null: false
      t.text :introduction, null: false
      t.string :abroad_living_summary, null: false

      t.timestamps
    end
  end
end
