require 'rake'
require 'minitest/autorun'

class BuildTaskTest < Minitest::Test
  def setup
    Rake.application.rake_require 'tasks/build'
    Rake::Task.define_task(:environment)
    @task = Rake::Task['build:episodes_yml_from_rss']
  end

  def test_task_output
    feed_url = 'http://example.com/rss'
    file_path = './path/to/file'
    expected_output = "Feed URL: #{feed_url}\nFile Path: #{file_path}\n"

    out, = capture_io do
      @task.reenable
      Rake.application.invoke_task "build:episodes_yml_from_rss[#{feed_url},#{file_path}]"
    end

    assert_equal expected_output, out
  end
end
