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
class InterviewEpisode < ApplicationRecord
  belongs_to :episode, foreign_key: :episode_number, class_name: 'Episode', primary_key: :number, inverse_of: :interview
end
