# frozen_string_literal: true

module Descriptions
  module EpisodesHelper
    def chapter_time(chapter)
      chapter.time.split('.').first
    end
  end
end
