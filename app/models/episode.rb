# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  image_path    :string           not null
#  long_summary  :text             not null
#  number        :string           not null, primary key
#  season_number :integer
#  story_number  :integer
#  subtitle      :text             not null
#  summary       :text             not null
#  title         :string(200)      not null
#  type_name     :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_episodes_on_number                          (number) UNIQUE
#  index_episodes_on_season_number_and_story_number  (season_number,story_number) UNIQUE
#
# Foreign Keys
#
#  type_name  (type_name => episode_types.name)
#
class Episode < ApplicationRecord
  belongs_to :type, class_name: 'EpisodeType', foreign_key: :type_name, primary_key: :name, inverse_of: :episodes
  has_one :feed_spotify_for_podcasters, foreign_key: :episode_number, class_name: 'FeedsSpotifyForPodcaster',
                                        primary_key: :number, inverse_of: :episode
  has_many :speakers, class_name: 'EpisodeSpeaker', foreign_key: :episode_number, primary_key: :number,
                      inverse_of: :episode
  include HasGuestInterviews
  include HasReferences
  include HasChapters
  include HasTranscriptions

  def published_at
    feed_spotify_for_podcasters&.published_at
  end
end
