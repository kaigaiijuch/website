# frozen_string_literal: true

# == Schema Information
#
# Table name: published_episodes
#
#  audio_file_url  :string
#  creator         :string
#  description     :text
#  duration        :string
#  episode_number  :string
#  episode_type    :string
#  explicit        :boolean
#  guid            :string
#  image_path      :string
#  image_url       :string
#  long_summary    :text
#  number          :string           primary key
#  published_at    :datetime
#  season_number   :integer
#  season_number:1 :string
#  source_url      :string
#  story_number    :integer
#  story_number:1  :string
#  subtitle        :text
#  summary         :text
#  title           :string(200)
#  title:1         :string
#  type_name       :string
#  url             :string
#
class PublishedEpisode < ApplicationRecord
  self.primary_key = 'number'
  include Episode::HasGuestInterviews
  include Episode::HasReferences
  include Episode::HasChapters
  include Episode::HasTranscriptions
  include Episode::HasPhoto

  def readonly?
    true
  end
end
