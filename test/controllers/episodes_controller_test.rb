# frozen_string_literal: true

require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @episodes = PublishedEpisode.all
  end

  test 'should get show' do
    @episodes.each do |episode|
      get episode_path(episode)
      assert_response :success
      assert_equal "/episodes/#{episode.number}", episode_path(episode)
    end
  end

  test 'should get index' do
    get episodes_path
    assert_response :success
  end
end
