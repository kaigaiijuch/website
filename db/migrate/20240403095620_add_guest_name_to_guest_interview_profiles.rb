# frozen_string_literal: true

class AddGuestNameToGuestInterviewProfiles < ActiveRecord::Migration[7.1]
  def up
    add_column :guest_interview_profiles, :guest_name, :string
    execute 'UPDATE guest_interview_profiles SET guest_name = (SELECT name FROM guests WHERE id = guest_id)'
    change_column_null :guest_interview_profiles, :guest_name, false
  end

  def down
    remove_column :guest_interview_profiles, :guest_name, :string
  end
end
