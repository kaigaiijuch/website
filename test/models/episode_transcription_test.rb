# frozen_string_literal: true

require 'test_helper'

class EpisodeTranscriptionTest < ActiveSupport::TestCase
  test 'it should have right attributes' do
    episode_transcriptions = EpisodeTranscription.where(episode_number: '1-1').all
    assert_equal 6, episode_transcriptions.size

    episode_transcription = episode_transcriptions[2]
    assert_equal '00:00:18.649', episode_transcription.start_time
    assert_equal '00:00:19.789', episode_transcription.end_time
    assert_equal '所', episode_transcription.speaker
    assert_equal 'よろしくお願いします。', episode_transcription.text

    assert_equal episodes(:two), episode_transcription.episode
  end

  test 'it should have right associations' do
    episode_transcriptions = EpisodeTranscription.where(episode_number: '1-1').all

    assert_equal episode_transcriptions, episodes(:two).transcriptions
    assert_equal episodes(:two), episode_transcriptions[0].episode
  end

  test 'it should return nil array if the file not exists' do
    assert_equal [], EpisodeTranscription.where(episode_number: 'not-exists').all
  end
end
