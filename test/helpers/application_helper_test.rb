# frozen_string_literal: true

require 'test_helper'

module ApplicationHelperTest
  class SiteNameHelperTest < ActionView::TestCase
    test 'site_name() should return site_name' do
      assert_equal 'Site name', site_name
    end
  end

  class GoogleTagManagerIdHelperTest < ActionView::TestCase
    test 'google_tag_manager_id() should return tag id' do
      assert_equal 'GTM-XXXX', google_tag_manager_id
    end
  end

  class FeedbackGoogleFormURLHelperTest < ActionView::TestCase
    test 'google_tag_manager_id() should return tag id' do
      assert_equal 'https://docs.google.com/forms/d/e/123456xxxxxxxx/viewform?embedded=true',
                   feedback_google_form_url
    end

    test 'feedback_typeform_embed_tag() should return tag id' do
      assert_equal '<div data-tf-live="xxxbbbbb"></div><script src="//embed.typeform.com/next/embed.js"></script>',
                   feedback_typeform_embed_tag
    end
  end

  class DisableHelperTest < ActionView::TestCase
    test 'after disable_header() then content_for(:header) should return just simple header' do
      disable_header
      assert_equal content_for(:header), '<header></header>'
    end

    test 'after disable_footer() then content_for(:footer) should return just simple header' do
      disable_footer
      assert_equal content_for(:footer), '<footer></footer>'
    end
  end

  class DateFormatHelperTest < ActionView::TestCase
    test 'format_date_to_ymd(time) should return the formatted date string' do
      time = Time.zone.local(2022, 1, 31)
      assert_equal '2022-01-31', format_date_to_ymd(time)
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
end
