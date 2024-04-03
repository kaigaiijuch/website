# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_references
#
#  id             :integer          not null, primary key
#  caption        :text             not null
#  display_order  :integer          default(1), not null
#  episode_number :string           not null
#  link           :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_episode_references_on_episode_number_and_display_order  (episode_number,display_order) UNIQUE
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
class EpisodeReference < ApplicationRecord
  belongs_to :episode, primary_key: :number, foreign_key: :episode_number, inverse_of: :references

  validates :caption, presence: true
  validates :episode_number, presence: true, uniqueness: { scope: :display_order }
  validates :link, presence: true
  validates :display_order, presence: true, numericality: { only_integer: true, greater_than: 0 }
  default_scope { order(display_order: :asc) }
end
