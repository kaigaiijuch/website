# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_photos
#
#  id             :integer          not null, primary key
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
require 'test_helper'

class EpisodePhotoTest < ActiveSupport::TestCase
  test 'episode should have a relation with photos' do
    assert episode_photos(:one), episodes(:one).photos.first
    assert episode_photos(:two), PublishedEpisode.find('1-1').photos.first
    assert episode_photos(:three), UnpublishedEpisode.find('1-2').photos.first
    assert episodes(:one), episode_photos(:one).episode
    assert episodes(:two), episode_photos(:two).episode
    assert episodes(:three), episode_photos(:three).episode
  end
end
