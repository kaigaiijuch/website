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
end
