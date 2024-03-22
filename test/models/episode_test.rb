# frozen_string_literal: true

require 'test_helper'
require 'minitest/autorun'

class EpisodeTest < ActiveSupport::TestCase
  test 'episode should be initialized from hash' do
    hash = {
      'title' => '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話',
      'url' => 'https://podcasters.spotify.com/pod/show/kaigaiijuch/episodes/2-1-e2gujk0',
      'image_url' => 'https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_episode/39369574/39369574-1710787766777-e18c234d0961e.jpg',
      'pub_date' => '2024-03-18T21:00:00+00:00',
      'description' => "description\ntest\ntes\n"
    }
    episode = Episode.new(**hash)

    assert_equal '2-1', episode.number
    assert_equal '2-1', episode.id
    assert_equal '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話', episode.title
    assert_equal URI('https://podcasters.spotify.com/pod/show/kaigaiijuch/episodes/2-1-e2gujk0'), episode.url
    assert_equal URI('https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_episode/39369574/39369574-1710787766777-e18c234d0961e.jpg'),
                 episode.image_url
    assert_equal Time.new(2024, 3, 18, 21, 0, 0, '+00:00'), episode.pub_date
    assert_equal ActiveSupport::TimeWithZone, episode.pub_date.class
    assert_equal "description\ntest\ntes\n", episode.description
  end

  class SampleEpisode < Episode
    data_file 'test/fixtures/files/episodes.yml'
  end
  test 'episode can read all as flat Episode object' do
    episodes = SampleEpisode.all

    assert_equal Episode, episodes[0].class
    assert_equal '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話', episodes[0].title

    episode = SampleEpisode.find('0')
    assert_equal '#0 イントロダクション', episode.title
  end
end
