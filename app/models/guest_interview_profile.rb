# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profiles
#
#  id                    :integer          not null, primary key
#  abroad_living_summary :string           not null
#  guest_name            :string           not null
#  introduction          :text             not null
#  job_title             :string           not null
#  tagline               :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  guest_id              :integer          not null
#
# Indexes
#
#  index_guest_interview_profiles_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  guest_id  (guest_id => guests.id)
#
class GuestInterviewProfile < ApplicationRecord
  belongs_to :guest
end
