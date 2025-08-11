# frozen_string_literal: true

require 'test_helper'

module ApplicationHelperTest
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

  class ImageURLWithHostHelperTest < ActionView::TestCase
    test 'image_url_with_host(path) should return the image url with host' do
      assert_equal 'http://localhost:3001/image.jpg', image_url_with_host('/image.jpg')
    end
  end

  class DisableAnnotateRenderedViewWithFilenamesTest < ActionView::TestCase
    @disable_annotate_rendered_view_with_filenames = ActionView::Base.annotate_rendered_view_with_filenames

    Minitest.after_run do
      ActionView::Base.annotate_rendered_view_with_filenames = @disable_annotate_rendered_view_with_filenames
    end

    test 'annotate_rendered_view_with_filenames should be false when execute block
      but not effect the annotate_rendered_view_with_filenames config' do
      ActionView::Base.annotate_rendered_view_with_filenames = true
      annotate_rendered_view_with_filenames_value = nil
      executed = nil

      disable_annotate_rendered_view_with_filenames do
        annotate_rendered_view_with_filenames_value = ActionView::Base.annotate_rendered_view_with_filenames
        executed = true
      end

      assert_equal executed, true
      assert_equal annotate_rendered_view_with_filenames_value, false
      assert_equal ActionView::Base.annotate_rendered_view_with_filenames, true
    end

    test 'do nothing when annotate_rendered_view_with_filenames is false ' do
      ActionView::Base.annotate_rendered_view_with_filenames = false
      annotate_rendered_view_with_filenames_value = nil
      executed = nil

      disable_annotate_rendered_view_with_filenames do
        annotate_rendered_view_with_filenames_value = ActionView::Base.annotate_rendered_view_with_filenames
        executed = true
      end

      assert_equal executed, true
      assert_equal annotate_rendered_view_with_filenames_value, false
      assert_equal ActionView::Base.annotate_rendered_view_with_filenames, false
    end
  end
end
