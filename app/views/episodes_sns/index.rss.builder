# frozen_string_literal: true

xml.instruct! :xml, version: '1.0'
xml.rss version: '2.0', 'xmlns:atom': 'http://www.w3.org/2005/Atom' do
  xml.channel do
    xml.tag!('atom:link', href: episodes_sns_url(format: :rss), rel: 'self', type: 'application/rss+xml')
    @episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.image image_url_with_host(episode.image_path)
        xml.x [
          [episode.title, sns_mention(episode, :sns_x)].join("\s"),
          episode_url(episode),
          hashtags(episode)
        ].join("\n")
        xml.bluesky [
          [episode.title, sns_mention(episode, :sns_bluesky)].join("\s"),
          episode_url(episode),
          hashtags(episode)
        ].join("\n")
        xml.instagram_story_image episode_logo_image_url(episode)

        xml.pubDate episode.published_at.rfc822
        xml.link episode_url(episode)
        xml.guid episode_url(episode)
      end
    end
  end
end
