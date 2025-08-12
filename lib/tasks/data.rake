# frozen_string_literal: true

namespace :data do # rubocop:disable Metrics/BlockLength
  desc 'Fetch Spotify for podcasters RSS feed and save to database'
  task :fetch_feeds_spotify_for_podcasters, %i[feed_url] => :environment do |_, args| # rubocop:disable Metrics/BlockLength
    require 'net/http'

    url = URI(args.feed_url)
    puts "Feed URL: #{url}"

    response = Net::HTTP.get_response(
      url, {
        'Cache-Control' => 'no-cache, no-store, must-revalidate',
        'Pragma' => 'no-cache',
        'Expires' => '0'
      }
    )
    rss_feed = response.body

    feeds = FeedsParser.from_podcast_rss_feed(source_url: url, rss_feed:)
    puts "Total feeds: #{feeds.count}"

    puts 'saving feeds to database...'
    result = []
    FeedsSpotifyForPodcaster.transaction do
      feeds.each do |feed|
        puts "  episode number: #{feed.episode_number}"
        result << FeedsSpotifyForPodcaster.find_or_initialize_by(episode_number: feed.episode_number).tap do |record|
          record.assign_attributes(feed.to_h)
          record.save!
        end
      end
    end

    puts 'Feeds have been saved to database'
    result.each do |feed|
      puts "  #{feed.episode_number}: #{feed.title}"
    end
  end
end
