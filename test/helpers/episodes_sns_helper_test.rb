# frozen_string_literal: true

require 'test_helper'

class EpisodesSnsHelperTest < ActionView::TestCase
  include EpisodesSnsHelper

  class SnsMentionHelperTest < ActionView::TestCase
    test 'sns_mention returns empty string when episode has no guest_interview_profiles' do
      assert_equal '', sns_mention(episodes(:four), :sns_x)
    end

    test 'sns_mention returns empty string when guest_interview_profiles have no sns_x' do
      assert_equal '', sns_mention(episodes(:one), :sns_x)
    end

    test 'sns_mention returns mentions for episode with one guest_interview_profile with sns_x' do
      assert_equal '@x_account_one @x_account_one_two', sns_mention(episodes(:two), :sns_x)
    end

    test 'sns_mention returns mentions for episode with multiple guest_interview_profiles with sns_x' do
      assert_equal '@x_account_two', sns_mention(episodes(:yoga), :sns_x)
    end

    test 'sns_mention handles different target_sns symbols' do
      assert_equal '@x_account_one @x_account_one_two', sns_mention(episodes(:two), :sns_x)
    end

    test 'sns_mention handles non-existent target_sns gracefully' do
      assert_raises(NoMethodError) { sns_mention(episodes(:two), :non_existent_sns) }
    end
  end

  class HashtagsHelperTest < ActionView::TestCase
    test 'hashtags returns the default channel hashtag' do
      assert_equal '#海外移住channel', hashtags(episodes(:one))
    end
  end
end
