# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interviews
#
#  display_order              :integer          default(1), not null
#  episode_number             :string           not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  idx_on_episode_number_guest_interview_profile_id_967e3dfe76  (episode_number,guest_interview_profile_id) UNIQUE
#  index_guest_interviews_on_episode_number_and_display_order   (episode_number,display_order) UNIQUE
#  index_guest_interviews_on_guest_interview_profile_id         (guest_interview_profile_id)
#
# Foreign Keys
#
#  episode_number              (episode_number => episodes.number)
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#
class GuestInterview < ApplicationRecord
  belongs_to :episode, primary_key: :number, foreign_key: :episode_number, inverse_of: :guest_interviews
  belongs_to :guest_interview_profile
  has_one :guest, through: :guest_interview_profile
  default_scope { order(display_order: :asc) }

  validates :episode_number, uniqueness: { scope: :display_order }
end
