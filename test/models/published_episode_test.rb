# frozen_string_literal: true

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
end
