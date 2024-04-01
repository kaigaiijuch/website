# frozen_string_literal: true

# == Schema Information
#
# Table name: interview_episodes
#
#  episode_number :string           not null, primary key
#  season_number  :integer          not null
#  story_number   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_interview_episodes_on_season_number_and_story_number  (season_number,story_number) UNIQUE
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
require 'test_helper'

class InterviewEpisodeTest < ActiveSupport::TestCase
  test 'should read correct relations' do
    assert_equal InterviewEpisode.find('1-1').episode, Episode.find('1-1')
    assert_equal Episode.find('1-1').interview, InterviewEpisode.find('1-1')
  end

  test 'the pair of season_number and story_number cannot be duplicated' do
    assert_raises(ActiveRecord::RecordNotUnique) do
      InterviewEpisode.create!(episode_number: '1-1', season_number: 0, story_number: 0)
    end
  end

  test 'the episode_number cannot be duplicated' do
    assert_raises(ActiveRecord::RecordNotUnique) do
      InterviewEpisode.create!(episode_number: '2-1', season_number: 1, story_number: 1)
    end
  end
end
