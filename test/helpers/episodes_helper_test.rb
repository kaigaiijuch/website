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

    test 'episode_url_for() should return episode or preview path' do
      assert_equal '/episodes/0', episode_url_for(@episode)
      assert_equal '/preview/episodes/1-2', episode_url_for(UnpublishedEpisode.first)
    end
  end

  class MarkDownLinkHelperTest < ActionView::TestCase
    test 'markdown_link() should return linked html' do
      text = 'this is the [Link](http://example.com) for it' # markdown link
      expected_output = 'this is the <a target="_blank" rel="noopener" href="http://example.com">Link</a> for it'
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should return linked html for multiple links' do
      text = 'this is the [Link](http://example.com) for it and [Another](https://example.org)' # markdown link
      expected_output = 'this is the <a target="_blank" rel="noopener" href="http://example.com">Link</a> for it and <a target="_blank" rel="noopener" href="https://example.org">Another</a>' # rubocop:disable Layout/LineLength
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should do nothing without links' do
      text = 'this is the text without link'
      assert_equal text, markdown_link(text)
    end
  end
end
