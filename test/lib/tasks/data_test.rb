# frozen_string_literal: true

require 'test_helper'
require 'rake'

class DataTaskTest < ActiveSupport::TestCase
  setup do
    Rake.application.rake_require 'tasks/data'
    Rake::Task.define_task(:environment)
    # clean the database
    FeedsSpotifyForPodcaster.delete_all

    @feed_url = 'https://example.com/rss'
    stub_request(:get, @feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))
  end

  test 'task fetch_feed_spotify_for_podcasters should accept url and create to database, update to database' do
    stub_request(:get, @feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].invoke(@feed_url)
    end

    assert_empty err
    assert_equal created_output, out
    assert_equal 4, FeedsSpotifyForPodcaster.count
    assert_equal %w[0 1-1 1-2 2-1], FeedsSpotifyForPodcaster.order(:episode_number).pluck(:episode_number)
  end

  test 'task fetch_feed_spotify_for_podcasters should accept url and update to database' do
    expected_output = created_output + <<~OUTPUT
      Feed URL: #{@feed_url}
      Total feeds: 1
      saving feeds to database...
        episode number: 0
      Feeds have been saved to database
        0: (no episode number) イントロダクション updated
    OUTPUT

    out, err = capture_io do
      execute_rake_task

      stub_request(:get, @feed_url).to_return(body: File.read('test/files/feed_spotify_for_podcasters.updated.rss'))
      execute_rake_task
    end

    assert_empty err
    assert_equal expected_output, out
    assert_equal 4, FeedsSpotifyForPodcaster.count
    assert_equal '(no episode number) イントロダクション updated', FeedsSpotifyForPodcaster.find('0').title
    assert_equal '海外移住channel updated #0 ', FeedsSpotifyForPodcaster.find('0').description
  end

  test 'task fetch_feed_spotify_for_podcasters should be atomic operation, not save any record when the error occurs' do
    skip 'not write the test yet'
  end

  private

  def execute_rake_task
    Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(Rake::TaskArguments.new([:feed_url], [@feed_url]))
  end

  def created_output
    <<~OUTPUT
      Feed URL: #{@feed_url}
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
        0:  (no episode number) イントロダクション
    OUTPUT
  end
end
