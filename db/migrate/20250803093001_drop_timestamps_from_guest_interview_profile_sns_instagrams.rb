# frozen_string_literal: true

class DropTimestampsFromGuestInterviewProfileSnsInstagrams < ActiveRecord::Migration[7.1]
  def change
    remove_timestamps :guest_interview_profile_sns_instagrams
  end
end
