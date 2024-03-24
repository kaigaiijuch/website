# frozen_string_literal: true

require 'rake'
require 'minitest/autorun'
require 'webmock/minitest'

class BuildTaskTest < Minitest::Test
  def setup
    Rake.application.rake_require 'tasks/build'
    Rake::Task.define_task(:environment)
    @task = Rake::Task['build:data:episodes_yml_from_rss']
  end

  def test_task_output # rubocop:disable Metrics/MethodLength
    feed_url = 'http://example.com/rss'
    file_path = './tmp/data/episodes.yml'
    expected_output = <<~OUTPUT
      Feed URL: #{feed_url}
      File Path: #{file_path}
      Total episodes: 4
    OUTPUT

    stub_request(:get, feed_url).to_return(body: File.read('test/files/podcast_feed.rss'))

    out, = capture_io do
      Rake.application.invoke_task "build:data:episodes_yml_from_rss[#{feed_url},#{file_path}]"
    end

    assert_equal expected_output, out
    assert_equal File.read(file_path), File.read('test/data/episodes.yml')
  end
end
