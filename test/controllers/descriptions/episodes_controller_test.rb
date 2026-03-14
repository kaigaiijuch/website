# frozen_string_literal: true

require 'test_helper'

module Descriptions
  class EpisodesControllerTest < ActionDispatch::IntegrationTest
    test 'should get index' do
      get descriptions_episodes_path
      assert_response :success
    end

    test 'should get show' do
      get descriptions_episode_path(episodes(:one))
      assert_response :success

      get descriptions_episode_path(episodes(:two))
      assert_response :success
    end
  end
end
