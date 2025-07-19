# frozen_string_literal: true

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', 'xmlns:atom': 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.title t('site.name')
    xml.description t('site.description')
    xml.link root_url
    xml.tag!('atom:link', href: episodes_url(format: :rss), rel: 'self', type: 'application/rss+xml')

    @episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.image image_url_with_host(episode.image_path)
        xml.pubDate episode.published_at.rfc822
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end
