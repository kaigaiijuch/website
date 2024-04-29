# frozen_string_literal: true

# == Schema Information
#
# Table name: unpublished_episodes
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
#  image_path      :string
#  image_url       :string
#  long_summary    :text
#  number          :string
#  published_at    :datetime
#  season_number   :integer
#  season_number:1 :string
#  source_url      :string
#  story_number    :integer
#  story_number:1  :string
#  subtitle        :text
#  summary         :text
#  title           :string(200)
#  title:1         :string
#  type_name       :string
#  updated_at:1    :datetime
#  url             :string
#  created_at      :datetime
#  updated_at      :datetime
#
require 'test_helper'

class UnpublishedEpisodeTest < ActiveSupport::TestCase
  test 'PublishedEpisode should be exists on the episodes but not in feeds_spotify_for_podcasters' do
    assert_equal episodes(:three, :four, :yoga).map(&:number).sort, UnpublishedEpisode.pluck(:number).sort

    published_episode = UnpublishedEpisode.first
    assert_nil published_episode.published_at
    assert_nil published_episode.episode_number
  end
end
