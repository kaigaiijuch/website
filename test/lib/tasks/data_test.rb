# frozen_string_literal: true

require 'test_helper'
require 'rake'
class DataTaskTest < ActiveSupport::TestCase
  setup do
    Rake.application.rake_require 'tasks/data'
    Rake::Task.define_task(:environment)
    # workaround: delete all records due to unique constrains
    FeedsSpotifyForPodcaster.delete(FeedsSpotifyForPodcaster.pluck(:episode_number))
  end

  test 'task fetch_feed_spotify_for_podcasters should accept url and save to database' do
    feed_url = 'http://example.com/rss'
    expected_output = <<~OUTPUT
      Feed URL: #{feed_url}
      Total feeds: 4
      saving feeds to database...
      Feeds have been saved to database
        2-1: #2-1 アメリカ・ロサンゼルス/ニューヨーク ドイツ・ベルリン 映像ディレクター 細井 洋介さん 前半 移住の経緯や仕事の話
        1-2: #1-2 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 後半 現地就職や転職の経緯・子育て環境の話など
        1-1: #1-1 ドイツ・ベルリン ソフトウェアエンジニア 奥田 一成さん 前半 移住の経緯・現地企業での仕事環境の話
        0: #0 イントロダクション
    OUTPUT

    stub_request(:get, feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))

    out = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].invoke(feed_url)
    end

    assert_equal expected_output, out.join
  end

  test 'task fetch_feed_spotify_for_podcasters should be atomic operation, not save any record when the error occurs' do
    # not write the test yet
  end
end
