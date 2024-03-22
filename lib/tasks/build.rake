# frozen_string_literal: true

namespace :build do
  desc 'Generate episodes.yml from podcast RSS feed'
  task :episodes_yml_from_rss, %i[feed_url file_path] => :environment do |_, args|
    args.with_defaults(file_path: './data/episodes.yml')

    puts "Feed URL: #{args.feed_url}"
    puts "File Path: #{args.file_path}"

    episodes = EpisodesParser.from_podcast_rss_feed(Net::HTTP.get(URI(args.feed_url)))
    episodes = episodes.map(&:to_h).reduce({}, :merge)
    File.write(args.file_path, episodes.to_yaml)
  end
end
