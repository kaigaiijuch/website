# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interviews
#
#  display_order  :integer          default(1), not null
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

    episode_one = Episode.find('1-1')
    assert_equal episode_one, guest_interview.episode
    assert_equal GuestInfo.find(1), guest_interview.guest_info
    assert_equal Guest.find(1), guest_interview.guest

    assert_equal 1, episode_one.guest_interviews.count
    assert_equal 1, episode_one.guest_infos.count
    assert_equal GuestInfo.find(1), episode_one.guest_infos.first
    assert_equal 1, episode_one.guests.count
    assert_equal Guest.find(1), episode_one.guests.first

    episode_zero = Episode.find('0')
    assert_equal 0, episode_zero.guest_infos.count
    assert_equal 0, episode_zero.guests.count

    episode_yoga = Episode.find('108')
    assert_equal 2, episode_yoga.guest_interviews.count
    assert_equal 2, episode_yoga.guest_infos.count
    assert_equal 2, episode_yoga.guests.count

    # check the order of guests
    assert_equal Guest.find_by(nickname: 'chikahiro'), episode_yoga.guests.first
    assert_equal 1, episode_yoga.guest_interviews.first.display_order
    assert_equal Guest.find_by(nickname: 'yosuke-san'), episode_yoga.guests.second
    assert_equal 2, episode_yoga.guest_interviews.second.display_order
  end
end
