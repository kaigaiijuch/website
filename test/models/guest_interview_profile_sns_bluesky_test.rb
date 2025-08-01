# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profile_sns_blueskies
#
#  id                         :integer          not null, primary key
#  account                    :string           not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  idx_on_guest_interview_profile_id_c93c656b70  (guest_interview_profile_id)
#
# Foreign Keys
#
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#
require 'test_helper'

class GuestInterviewProfileSnsBlueskyTest < ActiveSupport::TestCase
  test 'should have correct attributes and relations' do
    assert_equal guest_interview_profiles(:one), guest_interview_profile_sns_blueskies(:one).guest_interview_profile
  end

  test 'mention returns with @' do
    assert_equal '@alice.bsky.social', guest_interview_profile_sns_blueskies(:one).mention
  end

  test '#account should allow particular letters including dots' do
    sns_bluesky = guest_interview_profile_sns_blueskies(:one)

    sns_bluesky.account = "@#{sns_bluesky.account} "
    assert_equal false, sns_bluesky.valid?
    sns_bluesky.account = ' one'
    assert_equal false, sns_bluesky.valid?
    sns_bluesky.account = 'one '
    assert_equal false, sns_bluesky.valid?
    sns_bluesky.account = 'on e'
    assert_equal false, sns_bluesky.valid?

    sns_bluesky.account = 'user-1.bsky.social'
    assert sns_bluesky.valid?
  end
end
