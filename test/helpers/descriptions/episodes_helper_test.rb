# frozen_string_literal: true

require 'test_helper'

module Descriptions
  module EpisodesHelperTest
    class ChapterTimeHelperTest < ActionView::TestCase
      test 'chapter_time() should return HH:MM:SS' do
        chapter = EpisodeChapter.new(time: '01:02:03.456')
        assert_equal '01:02:03', chapter_time(chapter)
      end
    end

    class DisableAnnotateRenderedViewWithFilenamesTest < ActionView::TestCase
      @disable_annotate_rendered_view_with_filenames = ActionView::Base.annotate_rendered_view_with_filenames

      Minitest.after_run do
        ActionView::Base.annotate_rendered_view_with_filenames = @disable_annotate_rendered_view_with_filenames
      end

      test 'annotate_rendered_view_with_filenames should be false when execute block
        but not effect the annotate_rendered_view_with_filenames config' do
        ActionView::Base.annotate_rendered_view_with_filenames = true
        annotate_rendered_view_with_filenames_value = nil
        executed = nil

        disable_annotate_rendered_view_with_filenames do
          annotate_rendered_view_with_filenames_value = ActionView::Base.annotate_rendered_view_with_filenames
          executed = true
        end

        assert_equal executed, true
        assert_equal annotate_rendered_view_with_filenames_value, false
        assert_equal ActionView::Base.annotate_rendered_view_with_filenames, true
      end

      test 'do nothing when annotate_rendered_view_with_filenames is false ' do
        ActionView::Base.annotate_rendered_view_with_filenames = false
        annotate_rendered_view_with_filenames_value = nil
        executed = nil

        disable_annotate_rendered_view_with_filenames do
          annotate_rendered_view_with_filenames_value = ActionView::Base.annotate_rendered_view_with_filenames
          executed = true
        end

        assert_equal executed, true
        assert_equal annotate_rendered_view_with_filenames_value, false
        assert_equal ActionView::Base.annotate_rendered_view_with_filenames, false
      end
    end
  end
end
