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
require 'test_helper'

class GuestInterviewTest < ActiveSupport::TestCase
  test 'should have guests and guest_infos with interview episode' do
    guest_interview = GuestInterview.first

    assert_equal Episode.find('1-1'), guest_interview.episode
    assert_equal GuestInfo.find(1), guest_interview.guest_info
    assert_equal Guest.find(1), guest_interview.guest

    assert_equal 1, Episode.find('1-1').guest_interviews.count
    assert_equal 1, Episode.find('1-1').guest_infos.count
    assert_equal GuestInfo.find(1), Episode.find('1-1').guest_infos.first
    assert_equal 1, Episode.find('1-1').guests.count
    assert_equal Guest.find(1), Episode.find('1-1').guests.first

    assert_equal 0, Episode.find('0').guest_infos.count
    assert_equal 0, Episode.find('0').guests.count
  end
end
