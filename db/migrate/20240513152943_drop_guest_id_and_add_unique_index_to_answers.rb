# frozen_string_literal: true

class DropGuestIdAndAddUniqueIndexToAnswers < ActiveRecord::Migration[7.1]
  def change
    remove_column :answers, :guest_id, :integer, null: false, index: true
    remove_index :answers, :guest_interview_profile_id
    add_index :answers, %i[guest_interview_profile_id question_number], unique: true
  end
end
