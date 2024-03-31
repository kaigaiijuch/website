# frozen_string_literal: true

# == Schema Information
#
# Table name: episodes
#
#  key           :integer          not null, primary key
#  long_summary  :text             not null
#  number        :integer
#  season        :integer
#  short_summary :text             not null
#  subtitle      :text             not null
#  title         :string(200)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_episodes_on_key     (key) UNIQUE
#  index_episodes_on_number  (number)
#  index_episodes_on_season  (season)
#
class Episode < ApplicationRecord
end
