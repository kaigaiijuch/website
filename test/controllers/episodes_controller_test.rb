# frozen_string_literal: true

require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    PublishedEpisode.all.each do |episode|
      get episode_path(episode)
      assert_response :success
      assert_equal "/episodes/#{episode.number}", episode_path(episode)
    end
  end
end
