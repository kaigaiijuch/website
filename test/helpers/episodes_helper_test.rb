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

  class AutoLinkUrlHelperTest < ActionView::TestCase
    require 'rails_autolink/helpers' # for freaky test

    test 'auto_link_url() should return a link with target _blank' do
      assert_equal '<a target="_blank" href="http://example.com">http://example.com</a>', auto_link_url('http://example.com')
    end

    test 'auto_link_url() should return a link with target _blank for https' do
      assert_equal '<a target="_blank" href="https://example.com">https://example.com</a>', auto_link_url('https://example.com')
    end

    test 'auto_link_url() should return a link with target _blank for www' do
      assert_equal '<a target="_blank" href="http://www.example.com">www.example.com</a>',
                   auto_link_url('www.example.com')
    end

    test 'auto_link_url() should return a link with target _blank for multiple urls' do
      assert_equal 'Visit <a target="_blank" href="http://example.com">http://example.com</a> or <a target="_blank" href="http://example.org">http://example.org</a>', # rubocop:disable Layout/LineLength
                   auto_link_url('Visit http://example.com or http://example.org')
    end

    test 'auto_link_url() should return original text if no url' do
      assert_equal 'No url here', auto_link_url('No url here')
    end
  end

  class SimpleFormatWithLinkNewHelperTest < ActionView::TestCase
    test 'simple_format_with_link_new() should return formatted text' do
      text = "Hello\nWorld"
      expected_output = "<p>Hello\n<br />World</p>"
      assert_equal expected_output, simple_format_with_link_new(text)
    end

    test 'simple_format_with_link_new() should sanitize attributes' do
      text = '<a href="http://example.com" target="_blank" onclick="alert(\'XSS\')">Link</a>'
      expected_output = '<p><a href="http://example.com" target="_blank">Link</a></p>'
      assert_equal expected_output, simple_format_with_link_new(text)
    end

    test 'simple_format_with_link_new() should not sanitize allowed attributes' do
      text = '<a href="http://example.com" target="_blank">Link</a>'
      expected_output = '<p><a href="http://example.com" target="_blank">Link</a></p>'
      assert_equal expected_output, simple_format_with_link_new(text)
    end
  end

  class MarkDownLinkHelperTest < ActionView::TestCase
    test 'markdown_link() should return linked html' do
      text = 'this is the [Link](http://example.com) for it' # markdown link
      expected_output = 'this is the <a target="_blank" rel="noopener" href="http://example.com">Link</a> for it'
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should return linked html with escaped \) in the end' do
      text = 'this is the [Andy Hunt](https://en.wikipedia.org/wiki/Andy_Hunt_(author\)) !' # with escaped \)
      expected_output = 'this is the <a target="_blank" rel="noopener" href="https://en.wikipedia.org/wiki/Andy_Hunt_(author)">Andy Hunt</a> !' # rubocop:disable Layout/LineLength
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should return linked html with non-escaped ) in the middle' do
      text = 'this is the [Andy Hunt](https://en.wikipedia.org/wiki/(Andy\)_Hunt) !'
      expected_output = 'this is the <a target="_blank" rel="noopener" href="https://en.wikipedia.org/wiki/(Andy)_Hunt)">Andy Hunt</a> !' # rubocop:disable Layout/LineLength
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should return linked html with escaped parenthes and another is not)' do
      text = 'the [Andy Hunt](https://en.wikipedia.org/wiki/Andy_Hunt_(author\)) and [Another](https://example.org) !'
      expected_output = 'the <a target="_blank" rel="noopener" href="https://en.wikipedia.org/wiki/Andy_Hunt_(author)">Andy Hunt</a> and <a target="_blank" rel="noopener" href="https://example.org">Another</a> !' # rubocop:disable Layout/LineLength
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should return linked html for multiple links' do
      text = 'this is the [Link](http://example.com) for it and [Another](https://example.org)'
      expected_output = 'this is the <a target="_blank" rel="noopener" href="http://example.com">Link</a> for it and <a target="_blank" rel="noopener" href="https://example.org">Another</a>' # rubocop:disable Layout/LineLength
      assert_equal expected_output, markdown_link(text)
    end

    test 'markdown_link() should do nothing without links' do
      text = 'this is the text without link'
      assert_equal text, markdown_link(text)
    end
  end
end
