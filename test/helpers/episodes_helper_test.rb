# frozen_string_literal: true

require 'test_helper'

module EpisodesHelperTest
  class EmbedUrlHelperTest < ActionView::TestCase
    setup do
      @episode = EpisodeYml.find_by(key: '2-1')
    end

    test 'embed_url() should return embed url' do
      assert_equal 'https://podcasters.spotify.com/pod/show/kaigaiijuch/embed/episodes/2-1-e2gujk0', embed_url(@episode)
    end
  end
end
