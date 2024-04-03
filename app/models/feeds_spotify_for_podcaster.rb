# frozen_string_literal: true

# == Schema Information
#
# Table name: feeds_spotify_for_podcasters
#
#  audio_file_url :string           not null
#  creator        :string           not null
#  description    :text             not null
#  duration       :string           not null
#  episode_number :string           not null, primary key
#  episode_type   :string           not null
#  explicit       :boolean          not null
#  guid           :string           not null
#  image_url      :string           not null
#  published_at   :datetime         not null
#  season_number  :string
#  source_url     :string           not null
#  story_number   :string
#  title          :string           not null
#  url            :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_feeds_spotify_for_podcasters_on_episode_number  (episode_number) UNIQUE
#  index_feeds_spotify_for_podcasters_on_published_at    (published_at)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
class FeedsSpotifyForPodcaster < ApplicationRecord
  belongs_to :episode, foreign_key: :episode_number, class_name: 'Episode', primary_key: :number,
                       inverse_of: :feed_spotify_for_podcasters
end
