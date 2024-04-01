# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  long_summary  :text             not null
#  number        :string           not null, primary key
#  season_number :integer
#  short_summary :text             not null
#  story_number  :integer
#  subtitle      :text             not null
#  title         :string(200)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type_id       :integer          not null
#
# Indexes
#
#  index_episodes_on_number                          (number) UNIQUE
#  index_episodes_on_season_number_and_story_number  (season_number,story_number) UNIQUE
#  index_episodes_on_type_id                         (type_id)
#
# Foreign Keys
#
#  type_id  (type_id => episode_types.id)
#
class Episode < ApplicationRecord
  belongs_to :type, class_name: 'EpisodeType', inverse_of: :episodes
  has_one :feed_spotify_for_podcasters, foreign_key: :episode_number, class_name: 'FeedsSpotifyForPodcaster',
                                        primary_key: :number, inverse_of: :episode
  has_many :guest_interviews, foreign_key: :episode_number, primary_key: :number, inverse_of: :episode
  has_many :guest_interview_profiles, through: :guest_interviews
  has_many :guests, through: :guest_interviews
end
