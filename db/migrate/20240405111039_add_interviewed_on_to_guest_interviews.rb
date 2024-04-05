# frozen_string_literal: true

class AddInterviewedOnToGuestInterviews < ActiveRecord::Migration[7.1]
  def up
    add_column :guest_interviews, :interviewed_on, :date
    execute 'UPDATE guest_interviews SET interviewed_on = (SELECT interviewed_on FROM guest_interview_profiles WHERE guest_interview_profiles.id = guest_interviews.guest_interview_profile_id)'
    change_column_null :guest_interviews, :interviewed_on, false
  end

  def down
    remove_column :guest_interviews, :interviewed_on
  end
end
