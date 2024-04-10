# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_speaker_roles
#
#  name :string           not null
#
# Indexes
#
#  index_episode_speaker_roles_on_name  (name) UNIQUE
#
require 'test_helper'

class EpisodeSpeakerRoleTest < ActiveSupport::TestCase
  test 'it has 4 types in the records' do
    assert_equal %w[Co-host Guest Guest2 Host], EpisodeSpeakerRole.order(:name).pluck(:name)
  end

  test 'it cannot create duplicate name' do
    assert_raises(ActiveRecord::RecordNotUnique) { EpisodeSpeakerRole.create(name: 'Host') }
  end
end
