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
    assert_equal 3, GuestInfo.count

    assert_equal 2, Guest.find(1).guest_infos.count
  end
end
