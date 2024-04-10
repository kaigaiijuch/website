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
#  idx_on_episode_number_speaker_id_role_name_ac8e577519  (episode_number,speaker_id,role_name) UNIQUE
#  index_episode_speakers_on_speaker_id                   (speaker_id)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#  role_name       (role_name => episode_speaker_roles.name)
#  speaker_id      (speaker_id => speakers.id)
#
class EpisodeSpeaker < ApplicationRecord
  belongs_to :role, class_name: 'EpisodeSpeakerRole', foreign_key: :role_name, primary_key: :name,
                    inverse_of: :episode_speakers
  belongs_to :speaker
  belongs_to :episode, foreign_key: :episode_number, primary_key: :number, inverse_of: :speakers
end
