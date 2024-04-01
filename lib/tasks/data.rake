# frozen_string_literal: true

namespace :data do
  desc 'Fetch Spotify for podcasters RSS feed and save to database'
  task :fetch_feeds_spotify_for_podcasters, %i[feed_url] => :environment do |_, args|
    require 'open-uri'

    url = URI(args.feed_url)
    puts "Feed URL: #{url}"

    feeds = FeedsParser.from_podcast_rss_feed(source_url: url, rss_feed: url.read)
    puts "Total feeds: #{feeds.count}"

    puts 'saving feeds to database...'
    result = []
    FeedsSpotifyForPodcaster.transaction do
      feeds.each do |feed|
        result << FeedsSpotifyForPodcaster.create!(feed.to_h)
      end
    end

    puts 'Feeds have been saved to database'
    result.each do |feed|
      puts "  #{feed.episode_number}: #{feed.title}"
    end
  end
end
