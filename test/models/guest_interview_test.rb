# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interviews
#
#  id                         :integer          not null, primary key
#  display_order              :integer          default(1), not null
#  episode_number             :string           not null
#  interviewed_on             :date             not null
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
require 'test_helper'

class GuestInterviewTest < ActiveSupport::TestCase
  test 'should have guests and guest_interview_profiles with interview episode' do
    episode_one = Episode.find('1-1')
    assert_equal episode_one, guest_interviews(:one).episode
    assert_equal guest_interview_profiles(:one), guest_interviews(:one).guest_interview_profile
    assert_equal guests(:one), guest_interviews(:one).guest

    assert_equal 1, episode_one.guest_interviews.count
    assert_equal 1, episode_one.guest_interview_profiles.count
    assert_equal guest_interview_profiles(:one), episode_one.guest_interview_profiles.first
    assert_equal 1, episode_one.guests.count
    assert_equal guests(:one), episode_one.guests.first

    episode_zero = Episode.find('0')
    assert_equal 0, episode_zero.guest_interview_profiles.count
    assert_equal 0, episode_zero.guests.count

    episode_yoga = Episode.find('108')
    assert_equal 2, episode_yoga.guest_interviews.count
    assert_equal 2, episode_yoga.guest_interview_profiles.count
    assert_equal 2, episode_yoga.guests.count
  end

  test 'the order of guests and guest_interviews should be correct' do
    episode_yoga = Episode.find('108')
    assert_equal Guest.find_by(nickname: 'chikahiro'), episode_yoga.guests.first
    assert_equal 1, episode_yoga.guest_interviews.first.display_order
    assert_equal Guest.find_by(nickname: 'yosuke-san'), episode_yoga.guests.second
    assert_equal 2, episode_yoga.guest_interviews.second.display_order
  end

  test 'the episode_number and guest_interview_profile_id should not be dupilicated' do
    guest_interview = GuestInterview.new(
      episode_number: guest_interviews(:yoga).episode_number,
      guest_interview_profile_id: guest_interviews(:yoga).guest_interview_profile_id,
      display_order: (guest_interviews(:yoga).display_order + 1),
      interviewed_on: Time.zone.today
    )

    assert_not guest_interview.valid?
    assert_raises(ActiveRecord::RecordNotUnique) do
      guest_interview.save!(validate: false)
    end
  end

  test 'the display_order and episode_number should not be dupilicated' do
    guest_interview = GuestInterview.new(
      episode_number: guest_interviews(:yoga).episode_number,
      guest_interview_profile_id: 3,
      display_order: guest_interviews(:yoga).display_order,
      interviewed_on: Time.zone.today
    )

    assert_not guest_interview.valid?
    assert_raises(ActiveRecord::RecordNotUnique) do
      guest_interview.save!(validate: false)
    end
  end
  test 'the display_order should be positive value and greater than zero' do
    guest_interview = GuestInterview.new(
      episode_number: guest_interviews(:yoga).episode_number,
      guest_interview_profile_id: 3,
      display_order: 0,
      interviewed_on: Time.zone.today
    )

    assert_not guest_interview.valid?
    assert_raises(ActiveRecord::StatementInvalid) do
      guest_interview.save!(validate: false)
    end
  end
end
