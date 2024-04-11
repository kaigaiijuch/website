# frozen_string_literal: true

# == Schema Information
#
# Table name: speakers
#
#  id         :integer          not null, primary key
#  image_path :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  global_id  :string           not null
#
require 'test_helper'

class SpeakerTest < ActiveSupport::TestCase
  test 'the relationship is correct' do
    assert_equal speakers(:chikahiro).who, hosts(:chikahiro)
    assert_equal speakers(:test1).who, guests(:one)

    guest_speaker = Speaker.new(name: 'Guest Speaker', image_path: 'guest.jpg',
                                global_id: guests(:one).to_global_id.to_s)
    assert_equal guest_speaker.who, guests(:one)
    guest_speaker.save!

    assert_equal 'gid://website/Guest/1', guest_speaker.global_id
    assert_equal 'gid://website/Guest/1', guest_speaker.read_attribute_before_type_cast(:global_id)
  end
end
