# frozen_string_literal: true

require 'test_helper'

class EpisodesSnsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get episodes_sns_path(format: :rss) # /episodes_sns.rss
    assert_response :success
  end
end
