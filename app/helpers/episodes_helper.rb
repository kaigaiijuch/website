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
  # TODO: there is a bug when the parenthesis is in the middle of the link, it will not be escaped, test case is skipped
  def markdown_link(text)
    text.gsub(MARKDOWN_LINK_REGEX_WITH_PARENTHESIS, link_to('\1', '\2)', target: '_blank', rel: 'noopener'))
        .gsub(MARKDOWN_LINK_REGEX, link_to('\1', '\2', target: '_blank', rel: 'noopener'))
  end
end
