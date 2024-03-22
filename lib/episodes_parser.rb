# frozen_string_literal: true

class EpisodesParser
  require 'rexml'

  def self.from_podcast_rss_feed(rss_feed) # rubocop:disable Metrics/AbcSize
    REXML::Document.new(rss_feed).elements.inject('rss/channel/item', []) do |items, item|
      items << Episode.new(
        title: item.elements['title'].text,
        url: item.elements['link'].text,
        image_url: item.elements['itunes:image']['href'],
        description: item.elements['description'].text,
        pub_date: item.elements['pubDate'].text
      )
    end
  end
end

class Episode
  attr_reader :title, :url, :pub_date, :image_url, :description

  def initialize(title:, url:, image_url:, pub_date:, description:)
    @title = title
    @url = URI.parse(url)
    @image_url = URI.parse(image_url)
    @pub_date = Time.zone.parse(pub_date)
    @description = description
  end
end
