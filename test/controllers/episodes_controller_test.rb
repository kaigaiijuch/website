# frozen_string_literal: true

require 'test_helper'

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  setup do
    flunk 'change to PublishedEpisodes'

    @episode = EpisodeYml.first
  end

  test 'should get show' do
    get episode_path(@episode)
    assert_response :success
    assert_equal '/episodes/2-1', episode_path(@episode)
  end
end
