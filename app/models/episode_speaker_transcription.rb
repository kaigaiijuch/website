# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_speaker_transcriptions
#
#  id                 :integer          not null, primary key
#  end_at             :string           not null
#  start_at           :string           not null
#  text               :text             not null
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
class EpisodeSpeakerTranscription < ApplicationRecord
  # workaround: start_at and end_at are strings because of the following reason:
  #   time type is stores as string in sqlite (https://www.sqlite.org/lang_datefunc.html) and time is casting to
  #    ActiveSupport::TimeWithZone somehow,  it's not working well with format of "00:00:00.000"
  belongs_to :episode_speaker
end
