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
class EpisodeChapter < ApplicationRecord
  belongs_to :episode, foreign_key: :episode_number, primary_key: :number, inverse_of: :chapters
  default_scope { order(:time) }
end
