require 'rake'
require 'minitest/autorun'
require 'webmock/minitest'

class BuildTaskTest < Minitest::Test
  def setup
    Rake.application.rake_require 'tasks/build'
    Rake::Task.define_task(:environment)
    @task = Rake::Task['build:episodes_yml_from_rss']
  end

  def test_task_output
    feed_url = 'http://example.com/rss'
    file_path = './data/episodes.yml'
    expected_output = "Feed URL: #{feed_url}\nFile Path: #{file_path}\n"

    stub_request(:get, feed_url).to_return(body: File.read('test/fixtures/files/podcast_feed.rss'))

    out, = capture_io do
      @task.reenable
      Rake.application.invoke_task "build:episodes_yml_from_rss[#{feed_url}]"
    end

    assert_equal expected_output, out
  end
end