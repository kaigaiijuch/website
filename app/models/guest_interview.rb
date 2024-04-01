# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interviews
#
#  episode_number :string           not null
#  guest_info_id  :integer          not null
#
# Indexes
#
#  index_guest_interviews_on_episode_number_and_guest_info_id  (episode_number,guest_info_id) UNIQUE
#  index_guest_interviews_on_guest_info_id                     (guest_info_id)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#  guest_info_id   (guest_info_id => guest_infos.id)
#
class GuestInterview < ApplicationRecord
  belongs_to :guest_info
  belongs_to :episode
end
