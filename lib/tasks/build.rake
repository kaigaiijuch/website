# frozen_string_literal: true

namespace :build do
  namespace :data do
    desc 'Generate episodes.yml from podcast RSS feed'
    task :episodes_yml_from_rss, %i[feed_url file_path] => :environment do |_, args|
      require 'open-uri'
      args.with_defaults(file_path: './data/episodes.yml')

      url = URI(args.feed_url)
      puts "Feed URL: #{args.feed_url}"
      puts "File Path: #{args.file_path}"

      episodes = EpisodesParser.from_podcast_rss_feed(url.read)
      puts "Total episodes: #{episodes.count}"

      episodes = episodes.map(&:to_h).reduce({}, :merge)
      File.write(args.file_path, episodes.to_yaml)
    end
  end
end
