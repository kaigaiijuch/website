# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profiles
#
#  id                    :integer          not null, primary key
#  abroad_living_summary :string           not null
#  introduction          :text             not null
#  job_title             :string           not null
#  tagline               :string           not null
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  guest_id              :integer          not null
#
# Indexes
#
#  index_guest_infos_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  guest_id  (guest_id => guests.id)
#
require 'test_helper'

class GuestInterviewProfilesTest < ActiveSupport::TestCase
  test 'should have correct attributes and relations' do
    assert_equal 4, GuestInterviewProfile.count

    guest_interview_profile =
      GuestInterviewProfile.where(guest: Guest.find_by(nickname: 'kaz')).order(:interviewed_on).last
    assert_equal 'ドイツ・ベルリン 8年 イギリス・ロンドン(予定)', guest_interview_profile.abroad_living_summary
    assert_equal '奥田 一成', guest_interview_profile.guest_name

    assert_equal guests(:one), guest_interview_profile.guest
    assert_equal 2, guests(:one).interview_profiles.count

    assert_equal [guest_interview_profile_sns_xes(:one), guest_interview_profile_sns_xes(:one_two)],
                 guest_interview_profiles(:one).sns_x
    assert_equal [guest_interview_profile_sns_blueskies(:one), guest_interview_profile_sns_blueskies(:one_two)],
                 guest_interview_profiles(:one).sns_bluesky
    assert_equal [guest_interview_profile_sns_instagrams(:one), guest_interview_profile_sns_instagrams(:one_two)],
                 guest_interview_profiles(:one).sns_instagram
  end
end
