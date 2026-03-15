# frozen_string_literal: true

require 'test_helper'

class EpisodesSnsHelperTest < ActionView::TestCase
  include EpisodesSnsHelper

  class GuestsSnsMentionHelperTest < ActionView::TestCase
    test 'guests_sns_mention returns empty string when episode has no guest_interview_profiles' do
      assert_equal '', guests_sns_mention(episodes(:four), :sns_x)
    end

    test 'guests_sns_mention returns empty string when guest_interview_profiles have no sns_x' do
      assert_equal '', guests_sns_mention(episodes(:one), :sns_x)
    end

    test 'guests_sns_mention returns mentions for episode with one guest_interview_profile with sns_x' do
      assert_equal '@alice_dev @alice_overseas', guests_sns_mention(episodes(:two), :sns_x)
    end

    test 'guests_sns_mention returns mentions for episode with multiple guest_interview_profiles with sns_x' do
      assert_equal '@bob_traveler', guests_sns_mention(episodes(:yoga), :sns_x)
    end

    test 'guests_sns_mention handles different target_sns symbols' do
      assert_equal '@alice_dev @alice_overseas', guests_sns_mention(episodes(:two), :sns_x)
    end

    test 'guests_sns_mention handles non-existent target_sns gracefully' do
      assert_raises(NoMethodError) { guests_sns_mention(episodes(:two), :non_existent_sns) }
    end
  end

  class HashtagsHelperTest < ActionView::TestCase
    test 'hashtags returns the default channel hashtag' do
      assert_equal '#海外移住channel', hashtags(episodes(:one))
    end
  end

  class HostsSnsMentionHelperTest < ActionView::TestCase
    test 'hosts_sns_mention returns mentions for episode with one host with sns_x' do
      assert_equal '@kibitan', hosts_sns_mention(episodes(:two), :sns_x)
    end

    test 'hosts_sns_mention returns mentions for episode with one host with sns_bluesky' do
      assert_equal '@chikahirotokoro.bsky.social', hosts_sns_mention(episodes(:two), :sns_bluesky)
    end

    # TEMPORARY: remove this and the 3 tests below when temporary_mention_for_host? is removed (after 2026-03-31).
    test 'hosts_sns_mention returns mentions for episode with one host with sns_instagram outside temporary period' do
      travel_to Time.zone.parse('2026-04-01 00:00:00') do
        assert_equal '@chikahiro.tokoro', hosts_sns_mention(episodes(:two), :sns_instagram)
      end
    end

    test 'hosts_sns_mention includes temporary host mention for sns_instagram during 2026-03-15 to 2026-03-31' do
      travel_to Time.zone.parse('2026-03-20 12:00:00') do
        assert_equal '@chikahiro.tokoro @jirohari', hosts_sns_mention(episodes(:two), :sns_instagram)
      end
    end

    test 'hosts_sns_mention excludes temporary host mention for sns_instagram before period' do
      travel_to Time.zone.parse('2026-03-14 23:59:59') do
        assert_equal '@chikahiro.tokoro', hosts_sns_mention(episodes(:two), :sns_instagram)
      end
    end

    test 'hosts_sns_mention excludes temporary host mention for sns_instagram after period' do
      travel_to Time.zone.parse('2026-04-01 00:00:00') do
        assert_equal '@chikahiro.tokoro', hosts_sns_mention(episodes(:two), :sns_instagram)
      end
    end
  end
end
