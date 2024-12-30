# frozen_string_literal: true

module EpisodesHelper
  def embed_url(episode)
    episode.url.to_s.gsub(%r{/episodes/}, '/embed/episodes/')
  end

  def episode_url_for(episode)
    episode.try(:preview?) ? preview_episode_path(episode) : episode_path(episode)
  end

  def auto_link_url(text)
    auto_link(text, html: { target: '_blank' })
  end

  def simple_format_with_link_new(text)
    simple_format(text, {}, { sanitize_options: { attributes: %w[target href] } })
  end

  MARKDOWN_LINK_REGEX = /\[(.*?)\]\((.*?)\)/
  MARKDOWN_LINK_REGEX_WITH_PARENTHESIS = /\[(.*?)\]\((.*?)\\\)\)/
  # if the link has ended with a parenthesis, it needs be escaped with a backslash
  #   e.g. https://en.wikipedia.org/wiki/Dave_Thomas_(programmer) -> [Dave Thomas](https://en.wikipedia.org/wiki/Dave_Thomas_(programmer\))
  def markdown_link(text)
    case text
    when MARKDOWN_LINK_REGEX_WITH_PARENTHESIS
      text.gsub(MARKDOWN_LINK_REGEX_WITH_PARENTHESIS, link_to('\1', '\2)', target: '_blank', rel: 'noopener'))
    when MARKDOWN_LINK_REGEX
      text.gsub(MARKDOWN_LINK_REGEX, link_to('\1', '\2', target: '_blank', rel: 'noopener'))
    else
      text
    end
  end
end
