# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_photos
#
#  id             :integer          not null, primary key
#  episode_number :string           not null
#  image_path     :string           not null
#
# Indexes
#
#  index_episode_photos_on_episode_number  (episode_number) UNIQUE
#
# Foreign Keys
#
#  episode_number  (episode_number => episodes.number)
#
require 'test_helper'

class EpisodePhotoTest < ActiveSupport::TestCase
  test 'episode should have a relation with photo' do
    assert episode_photos(:one), Episode.find('0').photo
    assert episode_photos(:two), PublishedEpisode.find('1-1').photo
    assert episode_photos(:three), UnpublishedEpisode.find('1-2').photo
    assert episodes(:one), episode_photos(:one).episode
    assert episodes(:two), episode_photos(:two).episode
    assert episodes(:three), episode_photos(:three).episode
  end
end
