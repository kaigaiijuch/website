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

  test 'should show photo on episode show page' do
    episode = PublishedEpisode.find('1-1')
    get episode_path(episode)
    assert_response :success
    assert_select 'figure.episode_photo', 2
    assert_select 'figure.episode_photo:nth-of-type(1) figcaption', 'nice photo!'
    assert_select 'figure.episode_photo:nth-of-type(2) figcaption a[href="http://example.com"]', 'nice photo!'
    assert_select 'figure.episode_photo:nth-of-type(2) figcaption', 'nice photo! です'
  end

  test 'should get index' do
    get episodes_path
    assert_response :success
  end

  test 'should get rss' do
    get episodes_path(format: :rss)
    assert_response :success
  end
end
