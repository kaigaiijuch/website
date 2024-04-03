# frozen_string_literal: true

class AddUniqueIndexToGuestInterviews < ActiveRecord::Migration[7.1]
  def change
    add_index :guest_interviews, %i[episode_number display_order], unique: true
  end
end
