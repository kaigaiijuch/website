# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_speakers
#
#  id             :integer          not null, primary key
#  episode_number :string           not null
#  role_name      :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  speaker_id     :integer          not null
#
# Indexes
#
#  index_episode_speakers_on_episode_number_and_speaker_id  (episode_number,speaker_id) UNIQUE
#  index_episode_speakers_on_role_name_and_episode_number   (role_name,episode_number) UNIQUE
#  index_episode_speakers_on_speaker_id                     (speaker_id)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#  role_name       (role_name => episode_speaker_roles.name)
#  speaker_id      (speaker_id => speakers.id)
#
require 'test_helper'

class EpisodeSpeakerTest < ActiveSupport::TestCase
  test 'the relations correct' do
    episode_speaker = episode_speakers(:zero_host)

    assert_equal episodes(:one), episode_speaker.episode
    assert_equal speakers(:chikahiro), episode_speaker.speaker
    assert_equal episode_speaker_roles(:host).name, episode_speaker.role_name
    skip episode_speaker_roles(:host), episode_speaker.role
  end
end
