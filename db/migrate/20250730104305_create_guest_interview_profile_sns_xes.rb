# frozen_string_literal: true

class CreateGuestInterviewProfileSnsXes < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_interview_profile_sns_xes do |t|
      t.references :guest_interview_profile, null: false, foreign_key: true
      t.string :account, null: false
    end
  end
end
