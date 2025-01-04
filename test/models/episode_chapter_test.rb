# frozen_string_literal: true

require 'test_helper'

class EpisodeChapterTest < ActiveSupport::TestCase
  test 'it should have right attributes' do
    episode_chapters = EpisodeChapter.where(episode_number: '0').all
    assert_equal 4, episode_chapters.size

    episode_chapter = episode_chapters.first
    assert_equal '海外移住 channel 始動', episode_chapter.title
    assert_equal '00:00:00.998', episode_chapter.time
    assert_equal episodes(:one), episode_chapter.episode
  end

  test 'it should have right associations' do
    episode_chapters = EpisodeChapter.where(episode_number: '0').all

    assert_equal episode_chapters, episodes(:one).chapters
    assert_equal episodes(:one), episode_chapters[0].episode
  end

  test 'it should return nil array if the file not exists' do
    assert_equal [], EpisodeChapter.where(episode_number: 'not-exists').all
  end
end
