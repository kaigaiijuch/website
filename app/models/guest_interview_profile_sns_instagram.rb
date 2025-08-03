# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profile_sns_instagrams
#
#  id                         :integer          not null, primary key
#  account                    :string           not null
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  idx_on_guest_interview_profile_id_b0d57bd7a9  (guest_interview_profile_id)
#
# Foreign Keys
#
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#
class GuestInterviewProfileSnsInstagram < ApplicationRecord
  belongs_to :guest_interview_profile
  validates :account, format: { with: /\A[a-zA-Z0-9_.]+\z/ }

  def mention
    "@#{account}"
  end
end
