# frozen_string_literal: true

# == Schema Information
#
# Table name: published_episodes
#
#  audio_file_url  :string
#  created_at:1    :datetime
#  creator         :string
#  description     :text
#  duration        :string
#  episode_number  :string
#  episode_type    :string
#  explicit        :boolean
#  guid            :string
#  image_url       :string
#  long_summary    :text
#  number          :string           primary key
#  published_at    :datetime
#  season_number   :integer
#  season_number:1 :string
#  short_summary   :text
#  source_url      :string
#  story_number    :integer
#  story_number:1  :string
#  subtitle        :text
#  title           :string(200)
#  title:1         :string
#  updated_at:1    :datetime
#  url             :string
#  created_at      :datetime
#  updated_at      :datetime
#  type_id         :integer
#
class PublishedEpisode < ApplicationRecord
  self.primary_key = 'number'

  def readonly?
    true
  end
end
