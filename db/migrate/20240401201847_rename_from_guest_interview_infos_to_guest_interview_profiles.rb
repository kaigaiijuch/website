# frozen_string_literal: true

class RenameFromGuestInterviewInfosToGuestInterviewProfiles < ActiveRecord::Migration[7.1]
  def change
    rename_table(:guest_infos, :guest_interview_profiles)
    rename_column(:guest_interviews, :guest_info_id, :guest_interview_profile_id)
  end
end
