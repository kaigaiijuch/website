# frozen_string_literal: true

require 'test_helper'

module ApplicationHelperTest
  class GoogleTagManagerIdHelperTest < ActionView::TestCase
    def setup
      Rails.application.config.x.google_tag_manager_id = 'GTM-XXXX'
    end

    test 'google_tag_manager_id() should return tag id' do
      assert_equal 'GTM-XXXX', google_tag_manager_id
    end
  end

  class FeedbackGoogleFormURLHelperTest < ActionView::TestCase
    def setup
      Rails.application.config.x.feedback_google_form_id = '123456xxxxxxxx'
    end

    test 'google_tag_manager_id() should return tag id' do
      assert_equal 'https://docs.google.com/forms/d/e/123456xxxxxxxx/viewform?embedded=true',
                   feedback_google_form_url
    end
  end

  class TitleHelperTest < ActionView::TestCase
    def setup
      Rails.application.config.x.website_title.base = 'base_title'
      Rails.application.config.x.website_title.separator = ' + '
    end

    test 'title() without call set_title() should return just base title' do
      assert_equal 'base_title', yield_title
    end

    test 'title() with call empty set_title() should return just base title' do
      title('')
      assert_equal 'base_title', yield_title
    end

    test 'title() with call set_tile() should return with combined base title' do
      title('test')
      assert_equal 'base_title + test', yield_title
    end

    test 'yield_title should return with passed base title' do
      assert_equal 'test base title', yield_title(base_title: 'test base title')
    end

    test 'yield_title should return with passed separator title' do
      title('test')
      assert_equal 'base_title - test', yield_title(separator: ' - ')
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
      time = Time.zone.local(2022, 12, 31)
      assert_equal '2022.12.31', format_date_to_ymd(time)
    end
  end
end
