# frozen_string_literal: true

require 'test_helper'

module Preview
  class EpisodesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @episodes = UnpublishedEpisode.all
    end

    test 'should get show' do
      @episodes.each do |episode|
        get preview_episode_path(episode)
        assert_response :success
        assert_equal "/preview/episodes/#{episode.number}", preview_episode_path(episode)
      end
    end

    test 'should get index' do
      get preview_episodes_path
      assert_response :success
    end

    test 'if preview is not allowed, it shows 403 error' do
      Rails.application.config.x.enable_preview = false

      get preview_episodes_path
      assert_response 403
    end
  end
end
