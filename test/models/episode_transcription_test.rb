# frozen_string_literal: true

# == Schema Information
#
# Table name: episode_transcriptions
#
#  id                 :integer          primary key
#  created_at:1       :datetime
#  created_at:2       :datetime
#  end_at             :string
#  episode_number     :string
#  id:1               :integer
#  id:2               :integer
#  image_path         :string
#  name               :string
#  role_name          :string
#  start_at           :string
#  text               :text
#  type_name          :string
#  updated_at:1       :datetime
#  updated_at:2       :datetime
#  created_at         :datetime
#  updated_at         :datetime
#  episode_speaker_id :integer
#  speaker_id         :integer
#
require 'test_helper'

class EpisodeTranscriptionTest < ActiveSupport::TestCase
  test 'EpisodeTranscription has relation with Episode and order by episode_number and start_at' do
    episode_transcriptions = EpisodeTranscription.all
    assert_equal 5, episode_transcriptions.size

    assert_equal episodes(:one), episode_transcriptions.find(1).episode
    assert_equal episode_transcriptions.find(4, 5), episodes(:two).transcriptions
  end
end
