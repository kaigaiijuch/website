# frozen_string_literal: true

namespace :data do # rubocop:disable Metrics/BlockLength
  desc 'Fetch Spotify for podcasters RSS feed and save to database'
  task :fetch_feeds_spotify_for_podcasters, %i[feed_url retry] => :environment do |_, args| # rubocop:disable Metrics/BlockLength
    require 'net/http'

    url = URI(args.feed_url)
    puts "Feed URL: #{url}"

    retry_count = (args.retry || '0').to_i
    # max_age_seconds = 1 * 60 * 60 # 1 hours in seconds
    max_age_seconds = 1 * 60 * 60 # 1 hours in seconds
    retry_delay = 60 # seconds

    if retry_count > 1
      puts "Retry mode enabled: #{retry_count} attempts with #{retry_delay}s delay"

      (1..retry_count).each do |attempt|
        puts "Attempt #{attempt} of #{retry_count}"

        response = Net::HTTP.get_response(
          url, {
            'Cache-Control' => 'no-cache, no-store, must-revalidate',
            'Pragma' => 'no-cache',
            'Expires' => '0'
          }
        )

        # Check response age header
        age_header = response['age']
        if age_header
          age_seconds = age_header.to_i
          puts "Response age: #{age_seconds} seconds (#{(age_seconds / 3600.0).round(2)} hours)"

          if age_seconds < max_age_seconds
            puts 'Response is fresh enough, proceeding...'
            rss_feed = response.body
            break
          else
            puts "Response is stale (age: #{age_seconds}s > max: #{max_age_seconds}s)"
          end
        else
          puts 'No age header found, assuming fresh response'
          rss_feed = response.body
          break
        end

        if attempt < retry_count
          puts "Retrying in #{retry_delay} seconds..."
          sleep retry_delay
        else
          puts 'Max attempts reached, using last response'
          rss_feed = response.body
        end
      end
    else
      response = Net::HTTP.get_response(
        url, {
          'Cache-Control' => 'no-cache, no-store, must-revalidate',
          'Pragma' => 'no-cache',
          'Expires' => '0'
        }
      )
      rss_feed = response.body
    end

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
