# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profile_sns_instagrams
#
#  id                         :integer          not null, primary key
#  account                    :string           not null
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
require 'test_helper'

class GuestInterviewProfileSnsInstagramTest < ActiveSupport::TestCase
  test 'should have correct attributes and relations' do
    assert_equal guest_interview_profiles(:one), guest_interview_profile_sns_instagrams(:one).guest_interview_profile
  end

  test 'mention returns with @' do
    assert_equal '@alice_dev', guest_interview_profile_sns_instagrams(:one).mention
  end

  test '#account should allow particular letters including dots and underscores' do
    sns_instagram = guest_interview_profile_sns_instagrams(:one)

    sns_instagram.account = "@#{sns_instagram.account} "
    assert_equal false, sns_instagram.valid?
    sns_instagram.account = ' one'
    assert_equal false, sns_instagram.valid?
    sns_instagram.account = 'one '
    assert_equal false, sns_instagram.valid?
    sns_instagram.account = 'on e'
    assert_equal false, sns_instagram.valid?
    sns_instagram.account = 'user-name'
    assert_equal false, sns_instagram.valid?

    sns_instagram.account = 'user_1.name'
    assert sns_instagram.valid?
    sns_instagram.account = 'username123'
    assert sns_instagram.valid?
    sns_instagram.account = 'user.name'
    assert sns_instagram.valid?
  end
end
