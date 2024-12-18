# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_transcriptions
#
#  id                 :integer          primary key
#  end_at             :string
#  episode_number     :string
#  id:1               :integer
#  id:2               :integer
#  image_path         :string
#  name               :string
#  role_name          :string
#  start_at           :string
#  text               :text
#  episode_speaker_id :integer
#  global_id          :string
#  speaker_id         :integer
#
class EpisodeTranscription < ApplicationRecord
  self.primary_key = :id
  belongs_to :episode, foreign_key: :episode_number, primary_key: :number, inverse_of: :transcriptions
end
