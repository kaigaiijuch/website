# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_chapters
#
#  id             :integer          not null, primary key
#  episode_number :string           not null
#  time           :string           not null
#  title          :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_episode_chapters_on_episode_number  (episode_number)
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
require 'test_helper'

class EpisodeChapterTest < ActiveSupport::TestCase
  test 'should have correct relation' do
    assert_equal episodes(:zero), episode_chapters(:zero_one).episode
    assert_equal [
      episode_chapters(:zero_one),
      episode_chapters(:zero_two),
      episode_chapters(:zero_three),
      episode_chapters(:zero_four)
    ], episodes(:zero).chapters
  end
end
