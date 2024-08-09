# frozen_string_literal: true

module Descriptions
  module EpisodesHelper
    def chapter_time(chapter)
      chapter.time.split('.').first
    end

    def disable_annotate_rendered_view_with_filenames(&)
      if ActionView::Base.annotate_rendered_view_with_filenames
        ActionView::Base.annotate_rendered_view_with_filenames = false
        yield
        ActionView::Base.annotate_rendered_view_with_filenames = true
      else
        yield
      end
    end
  end
end
