# frozen_string_literal: true

require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @episode = Episode.first
  end

  test 'should get show' do
    get episode_path(@episode)
    assert_response :success
  end
end
