# frozen_string_literal: true

require 'test_helper'

class EpisodesSnsHelperTest < ActionView::TestCase
  include EpisodesSnsHelper

  class SnsMentionHelperTest < ActionView::TestCase
    test 'guest_sns_mention returns empty string when episode has no guest_interview_profiles' do
      assert_equal '', guest_sns_mention(episodes(:four), :sns_x)
    end

    test 'guest_sns_mention returns empty string when guest_interview_profiles have no sns_x' do
      assert_equal '', guest_sns_mention(episodes(:one), :sns_x)
    end

    test 'guest_sns_mention returns mentions for episode with one guest_interview_profile with sns_x' do
      assert_equal '@alice_dev @alice_overseas', guest_sns_mention(episodes(:two), :sns_x)
    end

    test 'guest_sns_mention returns mentions for episode with multiple guest_interview_profiles with sns_x' do
      assert_equal '@bob_traveler', guest_sns_mention(episodes(:yoga), :sns_x)
    end

    test 'guest_sns_mention handles different target_sns symbols' do
      assert_equal '@alice_dev @alice_overseas', guest_sns_mention(episodes(:two), :sns_x)
    end

    test 'guest_sns_mention handles non-existent target_sns gracefully' do
      assert_raises(NoMethodError) { guest_sns_mention(episodes(:two), :non_existent_sns) }
    end
  end

  class HashtagsHelperTest < ActionView::TestCase
    test 'hashtags returns the default channel hashtag' do
      assert_equal '#海外移住channel', hashtags(episodes(:one))
    end
  end
end
