# frozen_string_literal: true

module EpisodesSnsHelper
  def guests_sns_mention(episode, target_sns)
    episode.guest_interview_profiles.flat_map(&target_sns).map(&:mention).join(' ')
  end

  def hashtags(_episode)
    "##{t('site.name')}" # TODO: extend to episode's original hashtags
  end

  def hosts_sns_mention(_episode, target_sns)
    # currently hard coded only for main host sns
    case target_sns
    when :sns_x
      '@kibitan'
    when :sns_instagram
      # TEMPORARY: remove the following suffix and temporary_mention_for_host? after 2026-03-31.
      '@chikahiro.tokoro' + (temporary_mention_for_host? ? ' @jirohari' : '')
    when :sns_bluesky
      '@chikahirotokoro.bsky.social'
    else
      ''
    end
  end

  private

  # TEMPORARY: Remove this method and the extra ' @jirohari' in :sns_instagram branch after 2026-03-31.
  def temporary_mention_for_host?
    start_at = Time.zone.parse('2026-03-15').beginning_of_day
    end_at = Time.zone.parse('2026-03-31').end_of_day
    now = Time.current
    now >= start_at && now <= end_at
  end
end
