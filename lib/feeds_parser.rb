# frozen_string_literal: true

class FeedsParser
  require 'rexml'

  def self.from_podcast_rss_feed(source_url:, rss_feed:) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    REXML::Document.new(rss_feed).elements.inject('rss/channel/item', []) do |items, item|
      items << Feed.new(
        title: item.elements['title'].text,
        url: item.elements['link'].text,
        image_url: item.elements['itunes:image']['href'],
        description: item.elements['description'].text,
        pub_date: item.elements['pubDate'].text,
        audio_file_url: item.elements['enclosure']['url'],
        creator: item.elements['dc:creator'].text,
        duration: item.elements['itunes:duration'].text,
        explicit: item.elements['itunes:explicit'].text,
        episode_number: item.elements['itunes:episode']&.text,
        season_number: item.elements['itunes:season']&.text,
        episode_type: item.elements['itunes:episodeType'].text,
        guid: item.elements['guid'].text,
        source_url:
      )
    end
  end

  class Feed
    attr_reader :number, :title, :url, :pub_date, :image_url, :description, :audio_file_url, :creator, :duration,
                :explicit, :episode_number, :season_number, :episode_type, :guid, :source_url

    def initialize(title:, url:, image_url:, pub_date:, description:, audio_file_url:, creator:, duration:, explicit:,
                   episode_number:, season_number:, episode_type:, guid:, source_url:)
      @number = title.match(/#(\S+)/)[1]
      @title = title
      @url = URI.parse(url)
      @image_url = URI.parse(image_url)
      @pub_date = Time.zone.parse(pub_date)
      @description = description
      @audio_file_url = URI.parse(audio_file_url)
      @creator = creator
      @duration = duration
      @explicit = (explicit == 'yes')
      @episode_number = episode_number
      @season_number = season_number
      @episode_type = episode_type
      @guid = guid
      @source_url = source_url
    end
  end
end
