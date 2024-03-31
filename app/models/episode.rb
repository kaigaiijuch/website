# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  long_summary  :text             not null
#  number        :string           not null, primary key
#  short_summary :text             not null
#  subtitle      :text             not null
#  title         :string(200)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  type_id       :integer          not null
#
# Indexes
#
#  index_episodes_on_number   (number) UNIQUE
#  index_episodes_on_type_id  (type_id)
#
# Foreign Keys
#
#  type_id  (type_id => episode_types.id)
#
class Episode < ApplicationRecord
  belongs_to :type, class_name: 'EpisodeType', inverse_of: :episodes
end
