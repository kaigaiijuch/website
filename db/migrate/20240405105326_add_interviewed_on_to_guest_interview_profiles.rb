# frozen_string_literal: true

class AddInterviewedOnToGuestInterviewProfiles < ActiveRecord::Migration[7.1]
  def up
    add_column :guest_interview_profiles, :interviewed_on, :date
    execute 'UPDATE guest_interview_profiles SET interviewed_on = created_at'
    change_column_null :guest_interview_profiles, :interviewed_on, false
  end

  def down
    remove_column :guest_interview_profiles, :interviewed_on
  end
end
