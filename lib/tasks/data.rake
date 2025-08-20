# frozen_string_literal: true

namespace :data do # rubocop:disable Metrics/BlockLength
  desc 'Fetch Spotify for podcasters RSS feed and save to database'
  task :fetch_feeds_spotify_for_podcasters, %i[feed_url retry] => :environment do |_, args| # rubocop:disable Metrics/BlockLength
    require 'net/http'

    # Configuration
    max_age_seconds = 1 * 60 * 60 # 1 hour in seconds
    retry_delay_seconds = 60
    no_cache_headers = {
      'Cache-Control' => 'no-cache, no-store, must-revalidate',
      'Pragma' => 'no-cache',
      'Expires' => '0'
    }.freeze

    # Helper methods
    def fetch_rss_response(url, headers)
      Net::HTTP.get_response(url, headers)
    end

    def response_fresh?(response, max_age_seconds)
      age_header = response['age']
      return true unless age_header # No age header means fresh

      age_seconds = age_header.to_i
      puts "Response age: #{age_seconds} seconds (#{(age_seconds / 3600.0).round(2)} hours)"

      age_seconds < max_age_seconds
    end

    def fetch_with_retry(url, retry_count, max_age_seconds, retry_delay, headers)
      puts "Retry mode enabled: #{retry_count} attempts with #{retry_delay}s delay"

      (1..retry_count).each do |attempt|
        puts "Attempt #{attempt} of #{retry_count}"
        response = fetch_rss_response(url, headers)

        return response.body if response_fresh?(response, max_age_seconds)

        handle_stale_response(attempt, retry_count, max_age_seconds, retry_delay, response)
      end
    end

    def handle_stale_response(attempt, retry_count, max_age_seconds, retry_delay, response)
      puts "Response is stale (max age: #{max_age_seconds}s)"

      if attempt < retry_count
        puts "Retrying in #{retry_delay} seconds..."
        sleep retry_delay
      else
        puts 'Max attempts reached, using last response'
        response.body
      end
    end

    def save_feeds_to_database(feeds)
      puts 'Saving feeds to database...'
      result = []

      FeedsSpotifyForPodcaster.transaction do
        feeds.each do |feed|
          puts "  episode number: #{feed.episode_number}"
          result << create_or_update_feed(feed)
        end
      end

      print_saved_feeds(result)
      result
    end

    def create_or_update_feed(feed)
      FeedsSpotifyForPodcaster.find_or_initialize_by(episode_number: feed.episode_number).tap do |record|
        record.assign_attributes(feed.to_h)
        record.save!
      end
    end

    def print_saved_feeds(feeds)
      puts 'Feeds have been saved to database'
      feeds.each { |feed| puts "  #{feed.episode_number}: #{feed.title}" }
    end

    # Main execution
    url = URI(args.feed_url)
    puts "Feed URL: #{url}"

    retry_count = (args.retry || '0').to_i

    rss_feed = if retry_count > 1
                 fetch_with_retry(url, retry_count, max_age_seconds, retry_delay_seconds, no_cache_headers)
               else
                 fetch_rss_response(url, no_cache_headers).body
               end

    feeds = FeedsParser.from_podcast_rss_feed(source_url: url, rss_feed:)
    puts "Total feeds: #{feeds.count}"

    save_feeds_to_database(feeds)
  end
end
