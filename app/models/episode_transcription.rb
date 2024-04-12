# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_transcriptions
#
#  id                 :integer          primary key
#  created_at:1       :datetime
#  created_at:2       :datetime
#  end_at             :string
#  episode_number     :string
#  id:1               :integer
#  id:2               :integer
#  image_path         :string
#  name               :string
#  role_name          :string
#  start_at           :string
#  text               :text
#  type_name          :string
#  updated_at:1       :datetime
#  updated_at:2       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  episode_speaker_id :integer
#  speaker_id         :integer
#
class EpisodeTranscription < ApplicationRecord
  self.primary_key = :id
  belongs_to :episode, foreign_key: :episode_number, primary_key: :number, inverse_of: :transcriptions
end
