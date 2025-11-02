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
require 'test_helper'

class PublishedEpisodeTest < ActiveSupport::TestCase
  test 'PublishedEpisode should be combined Episode and FeedFeedsSpotifyForPodcaster' do
    assert_equal 2, PublishedEpisode.count

    published_episodes = PublishedEpisode.order(:published_at).all
    assert_equal published_episodes[0].number, episodes(:one).number
    assert_equal published_episodes[1].number, episodes(:two).number

    assert_equal published_episodes[0].url, feeds_spotify_for_podcasters(:two).url
    assert_equal published_episodes[1].url, feeds_spotify_for_podcasters(:one).url
  end

  test '#prev_episode returns the previous episode based on published_at' do
    # Episode "1-1" was published on March 4, 2024
    # Episode "0" was published on March 2, 2024
    latest_episode = PublishedEpisode.order(published_at: :desc).first
    oldest_episode = PublishedEpisode.order(published_at: :asc).first

    # The latest episode should have a previous episode (the oldest one)
    assert_equal oldest_episode.number, latest_episode.prev_episode.number

    # The oldest episode should not have a previous episode
    assert_nil oldest_episode.prev_episode
  end

  test '#next_episode returns the next episode based on published_at' do
    # Episode "1-1" was published on March 4, 2024
    # Episode "0" was published on March 2, 2024
    latest_episode = PublishedEpisode.order(published_at: :desc).first
    oldest_episode = PublishedEpisode.order(published_at: :asc).first

    # The oldest episode should have a next episode (the latest one)
    assert_equal latest_episode.number, oldest_episode.next_episode.number

    # The latest episode should not have a next episode
    assert_nil latest_episode.next_episode
  end

  test '#prev_episode and #next_episode work correctly with chronological order' do
    # Get episodes in chronological order
    oldest = PublishedEpisode.order(published_at: :asc).first
    newest = PublishedEpisode.order(published_at: :desc).first

    # Verify the chronological relationship
    assert_equal newest.number, oldest.next_episode.number
    assert_equal oldest.number, newest.prev_episode.number

    # Verify boundaries
    assert_nil oldest.prev_episode
    assert_nil newest.next_episode
  end
end
