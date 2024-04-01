# frozen_string_literal: true

class RenameFromGuestInfosToGuestInterviewInfos < ActiveRecord::Migration[7.1]
  def change
    rename_table(:guest_infos, :guest_interview_infos)
    rename_column(:guest_interviews, :guest_info_id, :guest_interview_info_id)
  end
end
