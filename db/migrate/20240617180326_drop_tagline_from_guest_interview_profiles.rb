# frozen_string_literal: true

class DropTaglineFromGuestInterviewProfiles < ActiveRecord::Migration[7.1]
  def change
    remove_column :guest_interview_profiles, :tagline, :string
  end
end
