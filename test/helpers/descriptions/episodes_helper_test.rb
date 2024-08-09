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
  end
end
