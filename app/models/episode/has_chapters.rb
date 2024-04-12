# frozen_string_literal: true

class Episode
  module HasChapters
    extend ActiveSupport::Concern

    def chapters
      @chapters ||= EpisodeChapter.where(episode_number: number).all
    end
  end
end
