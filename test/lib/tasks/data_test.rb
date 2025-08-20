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

  teardown do
    # Reset Rake tasks to allow re-execution
    Rake::Task['data:fetch_feeds_spotify_for_podcasters'].reenable
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
      Saving feeds to database...
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

  test 'task with retry parameter should retry when response is stale' do
    # First response with stale age header, then fresh response
    stub_request(:get, @feed_url)
      .to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'), headers: { 'Age' => '7200' })
      .then.to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'), headers: { 'Age' => '1800' })

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new([:feed_url, :retry, :max_age_seconds, :retry_delay_seconds], [@feed_url, '3', '', '1'])
      )
    end

    assert_empty err
    assert_includes out, 'Retry mode enabled: 3 attempts with 1s delay'
    assert_includes out, 'Attempt 1 of 3'
    assert_includes out, 'Response age: 7200 seconds'
    assert_includes out, 'Response is stale'
    assert_includes out, 'Attempt 2 of 3'
    assert_includes out, 'Response age: 1800 seconds'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  test 'task with retry should use fresh response without retrying' do
    stub_request(:get, @feed_url)
      .to_return(
        body: File.read('test/files/feed_spotify_for_podcasters.rss'),
        headers: { 'Age' => '1800' } # 30 minutes old, fresh
      )

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new([:feed_url, :retry, :max_age_seconds, :retry_delay_seconds], [@feed_url, '3', '', '1'])
      )
    end

    assert_empty err
    assert_includes out, 'Retry mode enabled: 3 attempts with 1s delay'
    assert_includes out, 'Attempt 1 of 3'
    assert_includes out, 'Response age: 1800 seconds'
    assert_not_includes out, 'Response is stale'
    assert_not_includes out, 'Attempt 2 of 3'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  test 'task with retry should assume fresh when no age header present' do
    stub_request(:get, @feed_url)
      .to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new([:feed_url, :retry, :max_age_seconds, :retry_delay_seconds], [@feed_url, '3', '', '1'])
      )
    end

    assert_empty err
    assert_includes out, 'Retry mode enabled: 3 attempts with 1s delay'
    assert_includes out, 'Attempt 1 of 3'
    assert_not_includes out, 'Response age:'
    assert_not_includes out, 'Response is stale'
    assert_not_includes out, 'Attempt 2 of 3'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  test 'task with custom max_age_seconds parameter' do
    stub_request(:get, @feed_url)
      .to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'), headers: { 'Age' => '1800' })
      .then.to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'), headers: { 'Age' => '600' })

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new(
          [:feed_url, :retry, :max_age_seconds, :retry_delay_seconds],
          [@feed_url, '3', '1200', '1'] # 20 minutes max age, 1 second delay
        )
      )
    end

    assert_empty err
    assert_includes out, 'Response age: 1800 seconds'
    assert_includes out, 'Response is stale (max age: 1200s)'
    assert_includes out, 'Response age: 600 seconds'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  test 'task should use last response when max attempts reached' do
    stub_request(:get, @feed_url)
      .to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'), headers: { 'Age' => '7200' })
      .times(2) # Explicitly allow 2 calls with same response

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new(
          [:feed_url, :retry, :max_age_seconds, :retry_delay_seconds],
          [@feed_url, '2', '3600', '1'] # 2 attempts, 1 hour max age, 1 second delay
        )
      )
    end

    assert_empty err
    assert_includes out, 'Attempt 1 of 2'
    assert_includes out, 'Attempt 2 of 2'
    assert_includes out, 'Max attempts reached, using last response'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  test 'task without retry should work normally' do
    stub_request(:get, @feed_url)
      .to_return(body: File.read('test/files/feed_spotify_for_podcasters.rss'))

    out, err = capture_io do
      Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(
        Rake::TaskArguments.new([:feed_url, :retry, :max_age_seconds, :retry_delay_seconds], [@feed_url, '1', '', '1'])
      )
    end

    assert_empty err
    assert_not_includes out, 'Retry mode enabled'
    assert_not_includes out, 'Attempt'
    assert_equal 4, FeedsSpotifyForPodcaster.count
  end

  private

  def execute_rake_task
    Rake::Task['data:fetch_feeds_spotify_for_podcasters'].execute(Rake::TaskArguments.new([:feed_url], [@feed_url]))
  end

  def created_output
    <<~OUTPUT
      Feed URL: #{@feed_url}
      Total feeds: 4
      Saving feeds to database...
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
