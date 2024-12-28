# frozen_string_literal: true

module EpisodesHelper
  def embed_url(episode)
    episode.url.to_s.gsub(%r{/episodes/}, '/embed/episodes/')
  end

  def episode_url_for(episode)
    episode.try(:preview?) ? preview_episode_path(episode) : episode_path(episode)
  end

  def markdown_link(text)
    if text.match(/\[.*\]\(.*\)/)
      text.gsub(/\[(.*?)\]\((.*?)\)/, link_to('\1', '\2', target: '_blank', rel: 'noopener'))
    else
      text
    end
  end
end
