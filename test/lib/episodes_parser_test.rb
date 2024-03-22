# frozen_string_literal: true

# this is the class that parse the podcast RSS feed and extract Episodes information to translate yaml file
# to a json file
# It is a test class that test the EpisodesGenerator class
require 'test_helper'
require 'episodes_parser'

class EpisodesParserTest < ActiveSupport::TestCase
  test 'should parse and return episodes' do
    file = open('test/fixtures/files/podcast_feed.rss')
    episodes = EpisodesParser.from_podcast_rss_feed(file.read)
    assert_equal 4, episodes.size
    assert_equal '#2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話', episodes[0].title
    assert_equal URI('https://podcasters.spotify.com/pod/show/kaigaiijuch/episodes/2-1-e2gujk0'), episodes[0].url
    assert_equal URI('https://d3t3ozftmdmh3i.cloudfront.net/staging/podcast_uploaded_episode/39369574/39369574-1710787766777-e18c234d0961e.jpg'),
                 episodes[0].image_url
    assert_equal Time.new(2024, 3, 18, 21, 0, 0, '+00:00'), episodes[0].pub_date
    assert_equal ActiveSupport::TimeWithZone, episodes[0].pub_date.class
  end
end
