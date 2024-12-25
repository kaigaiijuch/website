# frozen_string_literal: true

# == Schema Information
#
# Table name: unpublished_episodes
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
class UnpublishedEpisode < ApplicationRecord
  self.primary_key = 'number'
  include Episode::HasGuestInterviews
  include Episode::HasReferences
  include Episode::HasChapters
  include Episode::HasTranscriptions

  module Previewable
    def published_at
      1.day.from_now
    end

    def feed_spotify_for_podcasters; end

    def url
      'https://example.com/'
    end

    def preview?
      true
    end
  end
  include Previewable

  def readonly?
    true
  end
end
