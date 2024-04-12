# frozen_string_literal: true

# == Schema Information
#
# Table name: speaker_types
#
#  name :string           not null
#
# Indexes
#
#  index_speaker_types_on_name  (name) UNIQUE
#
require 'test_helper'

class SpeakerTypeTest < ActiveSupport::TestCase
  test 'the name is correct' do
    assert_equal 'host', speaker_types(:host).name
  end
end
