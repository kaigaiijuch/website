# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_transcriptions
#
#  id                 :integer          not null, primary key
#  end_at             :time             not null
#  start_at           :time             not null
#  text               :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  episode_speaker_id :integer          not null
#
# Indexes
#
#  index_episode_transcriptions_on_episode_speaker_id  (episode_speaker_id)
#
# Foreign Keys
#
#  episode_speaker_id  (episode_speaker_id => episode_speakers.id)
#
require 'test_helper'

class EpisodeTranscriptionTest < ActiveSupport::TestCase
  test 'check attributes' do
    episode_transcription = episode_transcriptions(:one)

    assert_equal '00:00:17.111', episode_transcription.start_at.strftime('%T')
    assert_equal '00:01:20.234', episode_transcription.end_at.strftime('%T')
    assert_equal '文字起こし始め', episode_transcription.text
    assert_equal episode_speakers(:chikahiro), episode_transcription.speaker
  end
end
