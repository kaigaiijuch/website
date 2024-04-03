# frozen_string_literal: true

class AddImagePathToGuestInterviewProfiles < ActiveRecord::Migration[7.1]
  def up
    add_column :guest_interview_profiles, :image_path, :string
    execute "UPDATE guest_interview_profiles SET image_path = CONCAT('guest_interview_profiles/', id, '.jpg')"
    change_column_null :guest_interview_profiles, :image_path, false
  end

  def down
    remove_column :guest_interview_profiles, :image_path, :string
  end
end
