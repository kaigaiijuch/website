# frozen_string_literal: true

module EpisodesHelper
  def embed_url(episode)
    episode.url.to_s.gsub(%r{/episodes/}, '/embed/episodes/')
  end

  def episode_url_for(episode)
    episode.try(:preview?) ? preview_episode_path(episode) : episode_path(episode)
  end
end
