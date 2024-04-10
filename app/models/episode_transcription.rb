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
class EpisodeTranscription < ApplicationRecord
  belongs_to :episode_speaker
end
