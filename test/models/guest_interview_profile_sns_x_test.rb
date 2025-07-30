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
    assert_equal '@x_account_one', guest_interview_profile_sns_xes(:one).mention
  end

  test 'should not allow to start with @' do
    sns_x = guest_interview_profile_sns_xes(:one)
    sns_x.account = "@#{sns_x.account} "
    assert_equal false, sns_x.valid?
  end
end
