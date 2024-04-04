# frozen_string_literal: true

require 'test_helper'

class EpisodeChapterTest < ActiveSupport::TestCase
  test 'it should have right attributes' do
    episode_chapter = EpisodeChapter.new(time: '00:00:00.123', title: 'test chapter')
    assert_equal 'test chapter', episode_chapter.title
    assert_equal '00:00:00.123', episode_chapter.time
    assert_equal episodes(:one), episode_chapter.episode
  end

  test 'it should have right associations' do
    assert_equal EpisodeChapter.all, episodes(:one).chapters
  end
end
