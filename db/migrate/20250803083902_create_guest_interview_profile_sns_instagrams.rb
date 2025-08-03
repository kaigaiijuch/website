# frozen_string_literal: true

class CreateGuestInterviewProfileSnsInstagrams < ActiveRecord::Migration[7.1]
  def change
    create_table :guest_interview_profile_sns_instagrams do |t|
      t.references :guest_interview_profile, null: false, foreign_key: true
      t.string :account, null: false

      t.timestamps
    end
  end
end
