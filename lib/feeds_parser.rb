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
        story_number: item.elements['itunes:episode']&.text,
        season_number: item.elements['itunes:season']&.text,
        episode_type: item.elements['itunes:episodeType'].text,
        guid: item.elements['guid'].text,
        source_url:
      )
    end
  end

  class Feed
    attr_reader :episode_number, :title, :url, :published_at, :image_url, :description, :audio_file_url, :creator,
                :duration, :explicit, :story_number, :season_number, :episode_type, :guid, :source_url

    def initialize(title:, url:, image_url:, pub_date:, description:, audio_file_url:, creator:, duration:, explicit:, # rubocop:disable Metrics/MethodLength, Metrics/ParameterLists
                   story_number:, season_number:, episode_type:, guid:, source_url:)

      @episode_number = detect_episode_number(description)
      @title = title
      @url = URI.parse(url)
      @image_url = URI.parse(image_url)
      @published_at = Time.zone.parse(pub_date)
      @description = description
      @audio_file_url = URI.parse(audio_file_url)
      @creator = creator
      @duration = duration
      @explicit = (explicit == 'yes')
      @story_number = story_number
      @season_number = season_number
      @episode_type = episode_type
      @guid = guid
      @source_url = source_url
    end

    def to_h
      instance_variables.inject({}) do |hash, var|
        hash.merge!(var.to_s.delete('@').to_sym => instance_variable_get(var))
      end
    end

    private

    EPISODE_NUMBER_REGEX = /#(\S+)\s*$/
    class NoEpisodeNumber < StandardError; end

    def detect_episode_number(text)
      raise NoEpisodeNumber unless EPISODE_NUMBER_REGEX.match?(text)

      text.match(EPISODE_NUMBER_REGEX)[1]
    end
  end
end
