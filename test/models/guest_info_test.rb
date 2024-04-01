# frozen_string_literal: true

# == Schema Information
#
# Table name: guest_infos
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

class GuestInfoTest < ActiveSupport::TestCase
  test 'should have correct attributes and relations' do
    assert_equal 4, GuestInfo.count

    guest_info = GuestInfo.where(guest: Guest.find_by(nickname: 'kaz')).order(:created_at).last
    assert_equal 'ドイツ・ベルリン 8年 イギリス・ロンドン(予定)', guest_info.abroad_living_summary

    assert_equal Guest.find(1), guest_info.guest
    assert_equal 2, Guest.find(1).infos.count
  end
end
