# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  display_order  :integer          default(1), not null
#  episode_number :string           not null
#  image_path     :string           not null
#
# Indexes
#
#  index_episode_photos_on_episode_number                    (episode_number)
#  index_episode_photos_on_episode_number_and_display_order  (episode_number,display_order) UNIQUE
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
class EpisodePhoto < ApplicationRecord
  include DisplayOrderable.with_uniqueness_scope(:episode_number)
  belongs_to :episode, primary_key: :number, foreign_key: :episode_number, inverse_of: :photos
end
