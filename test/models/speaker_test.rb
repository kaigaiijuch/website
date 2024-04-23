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
    assert_equal speakers(:test1).who, guests(:global_id_speaker)

    guest_speaker = Speaker.new(name: 'Guest Speaker', image_path: 'guest.jpg',
                                global_id: guests(:one).to_global_id)
    assert_equal guest_speaker.who, guests(:one)
    guest_speaker.save!
    guest_speaker.reload

    assert_equal "gid://website/Guest/#{guests(:one).id}", guest_speaker.global_id
    assert_equal "gid://website/Guest/#{guests(:one).id}", guest_speaker.read_attribute_before_type_cast(:global_id)

    host_speaker = Speaker.new(name: 'Guest Speaker', image_path: 'guest.jpg',
                               who: hosts(:chikahiro))
    assert_equal host_speaker.who, hosts(:chikahiro)
    host_speaker.save!

    assert_equal 'gid://website/Host/1', host_speaker.global_id
    assert_equal 'gid://website/Host/1', host_speaker.read_attribute_before_type_cast(:global_id)
  end

  test 'it allows only Host or Guest in who' do
    invalid_speaker = Speaker.new(name: 'In valid Speaker', image_path: 'guest.jpg',
                                  who: episodes(:one))
    assert_not invalid_speaker.valid?
  end
end
