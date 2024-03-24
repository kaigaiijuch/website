# frozen_string_literal: true

namespace :build do
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

  desc 'Build all artifacts for deployment'
  task :artifacts do
    puts 'creating sitemap.xml ...'
    Rake::Task['sitemap:create'].invoke
    puts 'assets precompile ...'
    Rake::Task['assets:precompile'].invoke
  end

  desc 'clean all artifacts for deployment'
  task :clean do
    puts 'cleaning sitemap.xml ...'
    Rake::Task['sitemap:clean'].invoke
    puts 'cleaning assets precompile ...'
    Rake::Task['assets:clobber'].invoke
  end
end
