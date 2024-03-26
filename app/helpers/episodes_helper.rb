# frozen_string_literal: true

module EpisodesHelper
  def embed_url(episode)
    episode.url.to_s.gsub(%r{/episodes/}, '/embed/episodes/')
  end
end
