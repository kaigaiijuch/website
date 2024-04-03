# frozen_string_literal: true

class CreateGuestInterviews < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_interviews, id: false do |t|
      t.string :episode_number, null: false, index: false
      t.references :guest_info, null: false, foreign_key: true

      t.foreign_key :episodes, column: :episode_number, primary_key: :number
      t.index %i[episode_number guest_info_id], unique: true
    end
  end
end
