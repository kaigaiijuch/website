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
  # test "the truth" do
  #   assert true
  # end
end
