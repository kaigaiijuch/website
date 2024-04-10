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
class EpisodeSpeakerRole < ApplicationRecord
end
