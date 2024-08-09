# frozen_string_literal: true

require 'test_helper'

module Descriptions
  class EpisodesControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get descriptions_episodes_path
      assert_response :success
    end

    test 'should get show' do
      get descriptions_episode_path(Episode.first)
      assert_response :success
    end
  end
end
