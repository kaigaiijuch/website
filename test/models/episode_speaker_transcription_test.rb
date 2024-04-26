# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_speaker_transcriptions
#
#  id                 :integer          not null, primary key
#  end_at             :string           not null
#  start_at           :string           not null
#  text               :text             not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  episode_speaker_id :integer          not null
#
# Indexes
#
#  index_episode_speaker_transcriptions_on_episode_speaker_id  (episode_speaker_id)
#
# Foreign Keys
#
#  episode_speaker_id  (episode_speaker_id => episode_speakers.id)
#
require 'test_helper'

class EpisodeSpeakerTranscriptionTest < ActiveSupport::TestCase
  test 'check attributes' do
    episode_speaker_transcription = EpisodeSpeakerTranscription.create(
      start_at: '00:12:56.999',
      end_at: '00:17:20.710',
      episode_speaker: episode_speakers(:zero_host),
      text: 'テスト'
    )

    assert_equal '00:12:56.999', episode_speaker_transcription.read_attribute_before_type_cast(:start_at)
    assert_equal '00:17:20.710', episode_speaker_transcription.read_attribute_before_type_cast(:end_at)
    assert_equal 'テスト', episode_speaker_transcription.text
    assert_equal episode_speakers(:zero_host), episode_speaker_transcription.episode_speaker

    episode_speaker_transcription = episode_speaker_transcriptions(:zero_one)

    assert_equal '00:00:17.111', episode_speaker_transcription.read_attribute_before_type_cast(:start_at)
    assert_equal '00:01:20.234', episode_speaker_transcription.read_attribute_before_type_cast(:end_at)
    assert_equal '文字起こし始め', episode_speaker_transcription.text
    assert_equal episode_speakers(:zero_host), episode_speaker_transcription.episode_speaker
  end
end
