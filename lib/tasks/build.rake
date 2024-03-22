# frozen_string_literal: true

namespace :build do
  desc 'Generate episodes.yml from podcast RSS feed'
  task :episodes_yml_from_rss, %i[feed_url file_path] => :environment do |_, args|
    args.with_defaults(file_path: './default/path/to/file')

    puts "Feed URL: #{args.feed_url}"
    puts "File Path: #{args.file_path}"
  end
end
