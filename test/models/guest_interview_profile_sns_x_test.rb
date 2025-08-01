# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_interview_profile_sns_xes
#
#  id                         :integer          not null, primary key
#  account                    :string           not null
#  guest_interview_profile_id :integer          not null
#
# Indexes
#
#  idx_on_guest_interview_profile_id_b309d95290  (guest_interview_profile_id)
#
# Foreign Keys
#
#  guest_interview_profile_id  (guest_interview_profile_id => guest_interview_profiles.id)
#
require 'test_helper'

class GuestInterviewProfileSnsXTest < ActiveSupport::TestCase
  test 'should have correct attributes and relations' do
    assert_equal guest_interview_profiles(:one), guest_interview_profile_sns_xes(:one).guest_interview_profile
  end

  test 'mention returns with @' do
    assert_equal '@alice_dev', guest_interview_profile_sns_xes(:one).mention
  end

  test '#account should follow X username rules' do
    sns_x = guest_interview_profile_sns_xes(:one)

    # Invalid cases
    sns_x.account = "@#{sns_x.account} "
    assert_equal false, sns_x.valid?
    sns_x.account = ' one'
    assert_equal false, sns_x.valid?
    sns_x.account = 'one '
    assert_equal false, sns_x.valid?
    sns_x.account = 'on e'
    assert_equal false, sns_x.valid?
    sns_x.account = 'one.1-'  # dots and hyphens not allowed
    assert_equal false, sns_x.valid?
    sns_x.account = 'a' * 16  # too long (16 characters)
    assert_equal false, sns_x.valid?
    sns_x.account = ''  # empty string
    assert_equal false, sns_x.valid?

    # Valid cases
    sns_x.account = 'user_123'
    assert sns_x.valid?
    sns_x.account = 'a'  # minimum length
    assert sns_x.valid?
    sns_x.account = 'a' * 15  # maximum length
    assert sns_x.valid?
  end
end
