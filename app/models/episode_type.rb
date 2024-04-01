# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_types
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_episode_types_on_name  (name) UNIQUE
#
class EpisodeType < ApplicationRecord
  # this is defined in podcast: https://podcasters.apple.com/support/825-how-to-create-an-episode
  #
  # Full: The complete content of your show.
  # Bonus: Extra content for your show (for example, behind-the-scenes information or interviews with the cast) or
  #   cross-promotional content for another show. Bonus episodes can be available to anyone or only to paid subscribers.
  # Trailer: A short, promotional piece of content that represents a preview of your current show.
  has_many :episodes, foreign_key: :type_id, inverse_of: :type
end
