# frozen_string_literal: true

require 'test_helper'
require 'rake'

class DataTaskTest < ActiveSupport::TestCase
  setup do
    Rake.application.rake_require 'tasks/data'
    Rake::Task.define_task(:environment)
  end

  test 'task fetch_feed_spotify_for_podcasters should accept url and create to database, update to database' do # rubocop:disable Metrics/BlockLength
    # clean the database
    FeedsSpotifyForPodcaster.delete(FeedsSpotifyForPodcaster.pluck(:episode_number))

    feed_url = 'http://example.com/rss'
    expected_output = <<~OUTPUT
      Feed URL: #{feed_url}
      Total feeds: 4
      saving feeds to database...
        episode number: 2-1
        episode number: 1-2
        episode number: 1-1
        episode number: 0
      Feeds have been saved to database
        2-1: #2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話
        1-2: #1-2 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 後半 現地就職や転職の経緯・子育て環境の話など
        1-1: #1-1 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 前半 移住の経緯・現地企業での仕事環境の話
        0: #0 イントロダクション
    OUTPUT

    stub_request(:get, feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].invoke(feed_url)
    end

    assert_empty err
    assert_equal expected_output, out
    assert_equal 4, FeedsSpotifyForPodcaster.count
    assert_equal %w[0 1-1 1-2 2-1], FeedsSpotifyForPodcaster.order(:episode_number).pluck(:episode_number)

    # update the database
    expected_output = <<~OUTPUT
      Feed URL: #{feed_url}
      Total feeds: 1
      saving feeds to database...
        episode number: 0
      Feeds have been saved to database
        0: #0 イントロダクション updated
    OUTPUT

    stub_request(:get, feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.updated.rss'))

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].invoke(feed_url)
    end

    skip "fix the test, it doesn't invoke the task again?"
    assert_empty err
    assert_equal expected_output, out
    assert_equal 4, FeedsSpotifyForPodcaster.count
    assert_equal '#0 イントロダクション updated', FeedsSpotifyForPodcaster.find('0').title
    assert_equal '海外移住channel updated', FeedsSpotifyForPodcaster.find('0').description
  end

  test 'task fetch_feed_spotify_for_podcasters should be atomic operation, not save any record when the error occurs' do
    skip 'not write the test yet'
  end
end
