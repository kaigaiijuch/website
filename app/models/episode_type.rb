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
  has_many :episodes, foreign_key: :type_id, inverse_of: :type # rubocop:disable Rails/HasManyOrHasOneDependent
end
