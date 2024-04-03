# frozen_string_literal: true

require 'test_helper'

module EpisodesHelperTest
  class EmbedUrlHelperTest < ActionView::TestCase
    setup do
      @episode = PublishedEpisode.find('0')
    end

    test 'embed_url() should return embed url' do
      assert_equal 'https://podcasters.spotify.com/pod/show/kaigaiijuch/embed/episodes/0-e2ghlp7', embed_url(@episode)
    end
  end
end
